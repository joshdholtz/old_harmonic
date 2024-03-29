//
//  HarmonicModel.swift
//  Harmonic
//
//  Created by Josh Holtz on 8/2/14.
//  Copyright (c) 2014 Josh Holtz. All rights reserved.
//

// This class exists so that the compiler knows that 'modelWithDictionary' function
// has an init method to instatiate with the 'self()' call. This prevents subclasses
// of HarmonicModel from needing to have their own implemention of init()
class HarmonicModelBase: NSObject {
    
    required init() {
        super.init();
    }
    
}

class HarmonicModel: HarmonicModelBase {
   
    // MARK: Class
    
    class func modelWithDictionary(json : Dictionary<String, AnyObject>) -> Self {
        var model = self();
        model.inflate(json);
        return model;
    }
    
    // MARK: Instance
    
    var jsonParsingError : NSError?;
    var json = Dictionary<String, AnyObject>();
    
    // Needed a garbage init method so the init() - with zero parameters) can be a convience method
    init(hack : Bool) {
        
    }
    
    // This is a convience method so that sublcasses can herit this? Maybe?
    convenience init() {
        self.init(hack: false);
    }
    
    convenience init(json : Dictionary<String, AnyObject>) {
        self.init();
        self.inflate(json);
    }
    
    convenience init(string : String) {
        self.init();
        
        let jsonData = string.dataUsingEncoding(UInt(NSUTF8StringEncoding), allowLossyConversion: false);
        let jsonDict = NSJSONSerialization.JSONObjectWithData(jsonData, options: nil, error: &jsonParsingError) as Dictionary<String, AnyObject>
        
        if (!self.jsonParsingError) {
            self.inflate(jsonDict);
        }
    }
    
    func keysToVariables() -> Dictionary<String, String> {
        fatalError("Must Override");
    }
    
    // MARK: Private
    
    func inflate(json : Dictionary<String, AnyObject>) {
        
        self.json = json;
        
        // Iterates over mappings
        for (jsonKey, variableName) in self.keysToVariables() {
            
            if (self.json[jsonKey]) {
                
                // JSON value
                var jsonValue : AnyObject = self.json[jsonKey]!;
            
                // Try/catching with Obj-C bridge
                var theTry = ({
                    () -> Void in
                    
                    var dotRange : NSRange = variableName.betterRangeOfString(".");
                    var colonRange : NSRange = variableName.betterRangeOfString(":");
                    
                    // Set the submodel variable
                    if (dotRange.location != Foundation.NSNotFound) {
                        var modelName : String = variableName.betterSubstringToIndex(dotRange.location);

                        var variableNameWithoutClass : String = variableName.betterSubstringFromIndex(dotRange.location + dotRange.length);

                        if (jsonValue is Dictionary<String, AnyObject>) {
                            var model : HarmonicModel? = self.instantiateModel(modelName);
                            model?.inflate( (jsonValue as Dictionary<String, AnyObject>) );
                            
                            if (model) {
                                self.setValue(model, forKey: variableNameWithoutClass);
                            }
                        } else if (jsonValue is Array<Dictionary<String, AnyObject>>) {
                            var models : Array<HarmonicModel> = [];
                            
                            for (json) in (jsonValue as Array<Dictionary<String, AnyObject>>) {
                                var model : HarmonicModel? = self.instantiateModel(modelName);
                                model?.inflate(json);
                                
                                if (model) {
                                    models += model!;
                                }
                            }

                            if (!models.isEmpty) {
                                self.setValue(models, forKey: variableNameWithoutClass);
                            }
                        }
                        
                    }
                    // Use the formatter function
                    else if (colonRange.location != Foundation.NSNotFound) {
                        
                        var formatterName : String = variableName.betterSubstringToIndex(colonRange.location);
                        
                        var variableNameWithoutFormatter : String = variableName.betterSubstringFromIndex(colonRange.location + colonRange.length);

                        var formattedValue : AnyObject? = HarmonicFormatter.sharedInstance.getFormatter(formatterName)?.formatter(value: jsonValue);

                        
                        self.setValue(formattedValue, forKey: variableNameWithoutFormatter);
                    }
                    // Just set the variable
                    else {
                        self.setValue(jsonValue, forKey: variableName);
                    }
                    
                });
                var theCatch = ({
                    (exception:NSException!) -> Void in
                    // Do something with the exception?
                });
                var theFinally = ({
                    () -> Void in
                    // Do something with the finally?
                });
                TryCatch.trying(theTry, withCatch: theCatch, withFinally: theFinally);
                
            }
            
        }
        
    }
    
    func instantiateModel(modelName : String) -> HarmonicModel? {
        var appName : String = "";
        if (HarmonicConfig.sharedInstance.dynamicModelOverrideName?) {
            appName = HarmonicConfig.sharedInstance.dynamicModelOverrideName!;
        } else if (HarmonicConfig.sharedInstance.unitTestMode) {
            appName = NSBundle.mainBundle().objectForInfoDictionaryKey("CFBundleName") as String
            appName = appName.stringByAppendingString("Tests");
        }
        
        
        var maybeModel: AnyObject! = InstantiateFromName.instantiateFromName(modelName, withAppName: appName);
        return maybeModel as? HarmonicModel;
    }
    
}

extension String {
    
    func betterRangeOfString(string : String) -> NSRange {
        return (self as NSString).rangeOfString(string);
    }
    
    func betterSubstringToIndex(to : Int) -> String {
        return ((self as NSString).substringToIndex(to) as String)
    }
    
    func betterSubstringFromIndex(to : Int) -> String {
        return ((self as NSString).substringFromIndex(to) as String)
    }
    
}
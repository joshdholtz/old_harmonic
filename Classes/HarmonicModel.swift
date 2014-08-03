//
//  HarmonicModel.swift
//  Harmonic
//
//  Created by Josh Holtz on 8/2/14.
//  Copyright (c) 2014 Josh Holtz. All rights reserved.
//

import UIKit

class HarmonicModel: NSObject {
   
    // MARK: Class
    
    class func modelWithDictionary(json : Dictionary<String, AnyObject>) -> Self {
        var model = self(json: json);
        return model;
    }
    
    // MARK: Instance
    
    var json = Dictionary<String, AnyObject>();
    
    required init() {
        super.init();
    }
    
    required init(json : Dictionary<String, AnyObject>) {
        super.init();
        self.inflate(json);
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

                        var model : HarmonicModel = (InstantiateFromName.instantiateFromName(modelName) as HarmonicModel);

                        var variableNameWithoutClass : String = variableName.betterSubstringFromIndex(dotRange.location + dotRange.length);

                        if (jsonValue is Dictionary<String, AnyObject>) {
                            model.inflate( (jsonValue as Dictionary<String, AnyObject>) );
                            self.setValue(model, forKey: variableNameWithoutClass);
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
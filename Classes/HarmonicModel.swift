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
    
    func keysToProperties() -> Dictionary<String, String> {
        fatalError("Must Override");
    }
    
    // MARK: Private
    
    func inflate(json : Dictionary<String, AnyObject>) {
        
        self.json = json;
        
        // Iterates over mappings
        for (jsonKey, propertyName) in self.keysToProperties() {
            
            if (self.json[jsonKey]) {
                
                // JSON value
                var jsonValue : AnyObject = self.json[jsonKey]!;
            
                // Try/catching with Obj-C bridge
                var theTry = ({
                    () -> Void in
                    
                    var dotRange : NSRange = propertyName.betterRangeOfString(".");
                    var colonRange : NSRange = propertyName.betterRangeOfString(":");
                    
                    // Set the submodel property
                    if (dotRange.location != Foundation.NSNotFound) {
                        var modelName : String = propertyName.betterSubstringToIndex(dotRange.location);

                        var model : HarmonicModel = (InstantiateFromName.instantiateFromName("_TtC8Harmonic9UserModel") as HarmonicModel);

                        var propertyNameWithoutClass : String = propertyName.betterSubstringFromIndex(dotRange.location + dotRange.length);

                        if (jsonValue is Dictionary<String, AnyObject>) {
                            model.inflate( (jsonValue as Dictionary<String, AnyObject>) );
                            self.setValue(model, forKey: propertyNameWithoutClass);
                        }
                        
                        
                    }
                    // Use the formatter function
                    else if (colonRange.location != Foundation.NSNotFound) {

                    }
                    // Just set the property
                    else {
                        self.setValue(jsonValue, forKey: propertyName);
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
        return (self as NSString).rangeOfString(".");
    }
    
    func betterSubstringToIndex(to : Int) -> String {
        return ((self as NSString).substringToIndex(to) as String)
    }
    
    func betterSubstringFromIndex(to : Int) -> String {
        return ((self as NSString).substringFromIndex(to) as String)
    }
    
}
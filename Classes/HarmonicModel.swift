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
    
    required init(json : Dictionary<String, AnyObject>) {
        super.init();
        self.json = json;
        self.inflate();
    }
    
    func keysToProperties() -> Dictionary<String, String> {
        fatalError("Must Override");
    }
    
    // MARK: Private
    
    func inflate() {
        
        // Iterates over mappings
        for (jsonKey, propertyName) in self.keysToProperties() {
            
            var jsonValue : AnyObject = self.json[jsonKey]!;
            self.setValue(jsonValue, forKey: propertyName);
            
        }
        
    }
    
}

//
//  HarmonicModelCollection.swift
//  Harmonic
//
//  Created by Josh Holtz on 8/2/14.
//  Copyright (c) 2014 Josh Holtz. All rights reserved.
//

class HarmonicModelCollection<T: HarmonicModel> {
    
    class func inflate(string : String, inout error : NSError?) -> Array<T> {

        let jsonData = string.dataUsingEncoding(UInt(NSUTF8StringEncoding), allowLossyConversion: false);
        var json = NSJSONSerialization.JSONObjectWithData(jsonData, options: nil, error: &error) as Array<Dictionary<String, AnyObject>>;
        
        if (error) {
            return [];
        }
        
        return HarmonicModelCollection.inflate(json);
    }
    
    class func inflate(json : Array<Dictionary<String, AnyObject>>) -> Array<T> {
        var models : Array<T> = [];
        for (obj) in json {
            models += T.modelWithDictionary(obj);
        }
        return models;
    }
    
}
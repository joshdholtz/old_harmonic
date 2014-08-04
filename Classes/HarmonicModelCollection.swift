//
//  HarmonicModelCollection.swift
//  Harmonic
//
//  Created by Josh Holtz on 8/2/14.
//  Copyright (c) 2014 Josh Holtz. All rights reserved.
//

class HarmonicModelCollection<T: HarmonicModel> {
    
    class func inflate(json : Array<Dictionary<String, AnyObject>>) -> Array<T> {
        var models : Array<T> = [];
        for (obj) in json {
            models += T.modelWithDictionary(obj);
        }
        return models;
    }
    
}
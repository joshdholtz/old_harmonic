//
//  HarmonicModelCollection.swift
//  Harmonic
//
//  Created by Josh Holtz on 8/2/14.
//  Copyright (c) 2014 Josh Holtz. All rights reserved.
//

import UIKit

//: MutableCollection, Sliceable

class HarmonicModelCollection<T: HarmonicModel> {
    
    var models : Array<T> = [];
    
    init(json : Array<Dictionary<String, AnyObject>>) {
        for (obj) in json {
            models += T.modelWithDictionary(obj);
        }
    }
    
}
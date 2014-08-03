//
//  UserModel.swift
//  Harmonic
//
//  Created by Josh Holtz on 8/2/14.
//  Copyright (c) 2014 Josh Holtz. All rights reserved.
//

import UIKit

class UserModel: HarmonicModel {
   
    var firstName : String?;
    var lastName : String?;
    var friend : UserModel?;
    var birthday : NSDate?;
    
    // Mapping function used to map JSON keys to HarmonicModel properties
    override func keysToProperties() -> Dictionary<String, String> {
        return [
            "first_name" : "firstName",
            "last_name" : "lastName",
            "middle_name" : "midName",
            "friend" : "UserModel.friend",
            "birthday" : "Birthday:birthday"
        ];
    }
    
    // Required for now (needed for dynamic instantiation)
    init() {
        super.init();
    }
    
    // Required for now (needed for dynamic instantiation)
    init(json: Dictionary<String, AnyObject>) {
        super.init(json: json);
    }
    
}

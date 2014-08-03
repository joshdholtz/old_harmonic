//
//  UserModel.swift
//  Harmonic
//
//  Created by Josh Holtz on 8/2/14.
//  Copyright (c) 2014 Josh Holtz. All rights reserved.
//

import UIKit

class UserModel: HarmonicModel {
   
    var firstName : String = "";
    var lastName : String = "";
    
    init(json: Dictionary<String, AnyObject>) {
        super.init(json: json);
    }

    override func keysToProperties() -> Dictionary<String, String> {
        return [
            "first_name" : "firstName",
            "last_name" : "lastName",
            "middle_name" : "MidName"
        ];
    }
    
}

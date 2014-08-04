//
//  BrokenModel.swift
//  Harmonic
//
//  Created by Josh Holtz on 8/3/14.
//  Copyright (c) 2014 Josh Holtz. All rights reserved.
//

class BrokenUserModel: HarmonicModel {
    
    var firstName : String?;
    var lastName : String?;
    var bestFriend : UserModel?;
    var friends : Array<UserModel>?;
    var birthday : NSDate?;

    // Mapping function used to map JSON keys to HarmonicModel variables
    override func keysToVariables() -> Dictionary<String, String> {
        return [
            "first_name" : "firstName",
            "last_name" : "elLastNameo",
            "best_friend" : "TMNTModel.bestFriend", // Inflates a UserModel from 'bestFriend' JSON Key to 'bestFriend' variable
            "friends" : "PowerRangerModel.friends", // Inflates an array UserModel from 'friends' JSON Key to 'friends' variable
            "birthday" : "NotAFunction:birthday"
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

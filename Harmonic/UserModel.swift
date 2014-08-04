//
//  UserModel.swift
//  Harmonic
//
//  Created by Josh Holtz on 8/2/14.
//  Copyright (c) 2014 Josh Holtz. All rights reserved.
//

class UserModel: HarmonicModel {
   
    var firstName : String?;
    var lastName : String?;
    var bestFriend : UserModel?;
    var friends : Array<UserModel> = [];
    var birthday : NSDate?;
    
    // Mapping function used to map JSON keys to HarmonicModel variables
    override func keysToVariables() -> Dictionary<String, String> {
        return [
            "first_name" : "firstName",
            "last_name" : "lastName",
            "middle_name" : "midName",
            "best_friend" : "UserModel.bestFriend", // Inflates a UserModel from 'bestFriend' JSON Key to 'bestFriend' variable
            "friends" : "UserModel.friends", // Inflates an array UserModel from 'friends' JSON Key to 'friends' variable
            "birthday" : "Birthday:birthday" // Formats 'birthday' JSON Key to 'birthday' variable with 'Birthday' formatter
        ];
    }
    
}

//
//  ViewController.swift
//  Harmonic
//
//  Created by Josh Holtz on 8/2/14.
//  Copyright (c) 2014 Josh Holtz. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
                            
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Formatter for Birthday
        HarmonicFormatter.sharedInstance.addFormatter("Birthday", formatter: HarmonicFormatterFunction(formatter:
            { (value: AnyObject) -> AnyObject in
                
                let dateStringFormatter = NSDateFormatter()
                dateStringFormatter.dateFormat = "yyyy-MM-dd"
                dateStringFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
                let date = dateStringFormatter.dateFromString(value as String);
                
                return date;
            }));

        // Sample parse JSON response
        var json : Dictionary<String, AnyObject> = ["first_name" : "Josh", "last_name" : "Holtz",
            "friend" : ["first_name" : "Bandit", "last_name" : "The Cat"],
            "birthday" : "1989-03-01"
        ];
        
        // Single model
        var user : UserModel = UserModel(json: json);
        println("User - \(user.firstName) \(user.lastName) \(user.birthday)")
        println("\tFriend - \(user.friend?.firstName) \(user.friend?.lastName)")
        
        // Collection of models
        var users = HarmonicModelCollection<UserModel>(json:[json]);
        var userInUsers = users.models[0];
        println("User in users - \(userInUsers.firstName) \(userInUsers.lastName) \(userInUsers.birthday)");
        println("\tFriend - \(userInUsers.friend?.firstName) \(userInUsers.friend?.lastName)")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


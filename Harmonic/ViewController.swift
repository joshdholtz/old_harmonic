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
            "best_friend" : ["first_name" : "Bandit", "last_name" : "The Cat"],
            "friends" : [ ["first_name" : "Red Ranger"], ["first_name" : "Green Ranger"] ],
            "birthday" : "1989-03-01"
        ];
        
        // Single model
        var user : UserModel = UserModel(json: json);
        println("User - \(user.firstName) \(user.lastName) \(user.birthday)")
        println("\tBest Friend - \(user.bestFriend?.firstName) \(user.bestFriend?.lastName)")
        for (friend) in user.friends {
            println("\tFriend - \(friend.firstName)")
        }
        
        // Collection of models
        var users = HarmonicModelCollection<UserModel>.inflate([json]);
        var userInUsers = users[0];
        println("User in users - \(userInUsers.firstName) \(userInUsers.lastName) \(userInUsers.birthday)");
        println("\tBest Friend - \(userInUsers.bestFriend?.firstName) \(userInUsers.bestFriend?.lastName)")
        for (friend) in user.friends {
            println("\tFriend - \(friend.firstName)")
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


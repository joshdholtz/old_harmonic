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

        var json : Dictionary<String, AnyObject> = ["first_name" : "Josh", "last_name" : "Holtz", "middle_name" : ""];
        
        var user : UserModel = UserModel(json: json);
        println("User - \(user.firstName) \(user.lastName)")
        
        var users = HarmonicModelCollection<UserModel>(json:[json]);
        var userInUsers = users.models[0];
        println("User in users - \(userInUsers.firstName) \(userInUsers.lastName)");
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


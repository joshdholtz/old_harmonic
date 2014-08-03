//
//  HarmonicTests.swift
//  HarmonicTests
//
//  Created by Josh Holtz on 8/2/14.
//  Copyright (c) 2014 Josh Holtz. All rights reserved.
//

import UIKit
import XCTest

import Harmonic

class HarmonicTests: XCTestCase {
    
    var jsonUser1 : Dictionary<String, AnyObject> = ["first_name" : "Josh", "last_name" : "Holtz",
        "best_friend" : ["first_name" : "Bandit", "last_name" : "The Cat"],
        "friends" : [ ["first_name" : "Red Ranger"], ["first_name" : "Green Ranger"] ],
        "birthday" : "1989-03-01"
    ];
    
    override func setUp() {
        super.setUp()
        
        // Need to set "unitTestMode" to true due to dynamic instantiation
        // Models are defaultly configured with the app name (which is the default target name)
        //
        // Since tests are run under a different target, this needs to be set so that Harmonic
        // knows to add "Test" onto the app name (ex: HarmonicTets)
        //
        // This could have also been done by the following line:
        //      HarmonicConfig.sharedInstance.dynamicModelOverrideName = "HarmonicTests";
        HarmonicConfig.sharedInstance.unitTestMode = true;
        
        // Initializing formatter functions and things
        AppDelegate.initHarmonic();
    }
    
    override func tearDown() {
        // Turning off cause why not
        HarmonicConfig.sharedInstance.unitTestMode = false;
        HarmonicFormatter.sharedInstance.formatters.removeAll();
        
        super.tearDown()
    }
    
    func testBasicModel() {
        var user : UserModel = UserModel(json: jsonUser1);

        // Standard variables
        XCTAssertEqual(jsonUser1["first_name"]! as String, user.firstName!, "First names should equal");
        XCTAssertEqual(jsonUser1["last_name"]! as String, user.lastName!, "Last name should equal ");
        
        // Single model assocation
        XCTAssertEqual(jsonUser1["best_friend"]!["first_name"]! as String, user.bestFriend!.firstName!, "Best friend's first names should equal");
        
        // Collection models association
        var firstFriend : Dictionary<String, AnyObject> = jsonUser1["friends"]![0] as Dictionary<String, AnyObject>;
        XCTAssertEqual(jsonUser1["friends"]!.count, user.friends.count, "Friend's count should equal");
        XCTAssertEqual(firstFriend["first_name"]! as String, user.friends[0].firstName!, "Friend's first name should be equal");
        
        // Formatter function
        XCTAssertNotNil(user.birthday, "Birthday should not be nil");
        
        var birthdayParts : Array<String> = (jsonUser1["birthday"]! as String).componentsSeparatedByString("-");
        XCTAssertEqual( birthdayParts[0].toInt()! ,  user.birthday!.year(), "Birthdy years should equal");
        XCTAssertEqual( birthdayParts[1].toInt()! ,  user.birthday!.month(), "Birthdy months should equal");
        XCTAssertEqual( birthdayParts[2].toInt()! ,  user.birthday!.day(), "Birthdy days should equal");
        
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock() {
            // Put the code you want to measure the time of here.
        }
    }
    
}

extension NSDate {
    
    func componentFor(component : NSCalendarUnit) -> Int {
        return NSCalendar.currentCalendar().component(component, fromDate: self);
    }
    
    func year() -> Int {
        return self.componentFor(NSCalendarUnit.YearCalendarUnit);
    }
    
    func month() -> Int {
        return self.componentFor(NSCalendarUnit.MonthCalendarUnit);
    }
    
    func day() -> Int {
        return self.componentFor(NSCalendarUnit.DayCalendarUnit);
    }
    
}

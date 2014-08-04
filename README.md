# Harmonic - iOS

A Swift library for loading JSON objects and array into Swift objects

```swift
var json : Dictionary<String, AnyObject> = ["first_name" : "Josh", "last_name" : "Holtz"];

var user : UserModel = UserModel(json: json);
println("User - \(user.firstName) \(user.lastName)");
```

### Updates

Version | Changes
--- | ---
**0.1.0** | Initial release

### Features
- Inflates models and collections

## Installation

### Drop-in Classes
Clone the repository and drop in the .swift files from the "Classes" directory into your project.

## Usage

### The Everything Example
1. Registers a formatter to take a string value of "yyyy-MM-dd" and transforms it to an NSDate
2. Hardcoded sample parse JSON response
3. Parses a single model
4. Parses a collection of models

```swift
// Some view controller or something

// Formatter for Birthday (advanced)
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
// Prints:  User - Optional("Josh") Optional("Holtz") Optional(1989-03-01 06:00:00 +0000)
//            Best Friend - Optional("Bandit") Optional("The Cat")
//            Friend - Optional("Red Ranger")
//            Friend - Optional("Green Ranger")
//
// Note: Names print with "Optional" wrapper because that is how I defined my UserModel variables

// Collection of models
var users = HarmonicModelCollection<UserModel>.inflate([json]);
var userInUsers = users[0];
println("User in users - \(userInUsers.firstName) \(userInUsers.lastName) \(userInUsers.birthday)");
println("\tBest Friend - \(userInUsers.bestFriend?.firstName) \(userInUsers.bestFriend?.lastName)")
for (friend) in user.friends {
    println("\tFriend - \(friend.firstName)")
}
// Prints:  User in users - Optional("Josh") Optional("Holtz") Optional(1989-03-01 06:00:00 +0000)
//            Best Friend - Optional("Bandit") Optional("The Cat")
//            Friend - Optional("Red Ranger")
//            Friend - Optional("Green Ranger")
//
// Note: Names print with "Optional" wrapper because that is how I defined my UserModel variables

```

```swift
// UserModel.swift
class UserModel: HarmonicModel {
   
    var firstName : String?;
    var lastName : String?;
    var bestFriend : UserModel?;
    var friends : Array<UserModel>?;
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
    
    // Required for now (needed for dynamic instantiation)
    init() {
        super.init();
    }
    
    // Required for now (needed for dynamic instantiation)
    init(json: Dictionary<String, AnyObject>) {
        super.init(json: json);
    }
    
}
```

## Author

Josh Holtz, me@joshholtz.com, [@joshdholtz](https://twitter.com/joshdholtz)

## License

Harmonic is available under the MIT license. See the LICENSE file for more info.


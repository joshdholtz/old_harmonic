# Harmonic - iOS

A library for loading JSON objects and array into Swift models and collections

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

### Very basic unexplained example

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
    "friend" : ["first_name" : "Bandit", "last_name" : "The Cat"],
    "birthday" : "1989-03-01"
];

// Single model
var user : UserModel = UserModel(json: json);
println("User - \(user.firstName) \(user.lastName)")
println("\tFriend - \(user.friend?.firstName) \(user.friend?.lastName)")
// Prints:  User - Optional("Josh") Optional("Holtz")
//            Friend - Optional("Bandit") Optional("The Cat")
//
// Note: Names print with "Optional" wrapper because that is how I defined my UserModel attributes

// Collection of models
var users = HarmonicModelCollection<UserModel>(json:[json]);
var userInUsers = users.models[0];
println("User in users - \(userInUsers.firstName) \(userInUsers.lastName)");
println("\tFriend - \(userInUsers.friend?.firstName) \(userInUsers.friend?.lastName)")
// Prints:  User in users - Optional("Josh") Optional("Holtz")
//            Friend - Optional("Bandit") Optional("The Cat")
//
// Note: Names print with "Optional" wrapper because that is how I defined my UserModel attributes

```

```swift
// UserModel.swift
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
```

## Author

Josh Holtz, me@joshholtz.com, [@joshdholtz](https://twitter.com/joshdholtz)

## License

Harmonic is available under the MIT license. See the LICENSE file for more info.


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

### Very basic example

```swift

var json : Dictionary<String, AnyObject> = ["first_name" : "Josh", "last_name" : "Holtz", "middle_name" : ""];

var user : UserModel = UserModel(json: json);
println("User - \(user.firstName) \(user.lastName)")

var users = HarmonicModelCollection<UserModel>(json:[json]);
var userInUsers = users.models[0];
println("User in users - \(userInUsers.firstName) \(userInUsers.lastName)");

```

## Author

Josh Holtz, me@joshholtz.com, [@joshdholtz](https://twitter.com/joshdholtz)

## License

Harmonic is available under the MIT license. See the LICENSE file for more info.


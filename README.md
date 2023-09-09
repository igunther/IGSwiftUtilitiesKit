# IGSwiftUtilitiesKit

<p>
    <img src="https://img.shields.io/badge/iOS-14.0+-blue.svg" />
    <img src="https://img.shields.io/badge/Swift-5.1-ff69b4.svg" />
    <a href="https://twitter.com/igunthercom">
        <img src="https://img.shields.io/badge/Contact-@igunthercom-lightgrey.svg?style=flat" alt="Twitter: @igunthercom" />
    </a>
</p>


**IGSwiftUtilitiesKit** is a comprehensive toolkit designed to supercharge your iOS development workflow. Whether you're delving into the realms of UIKit or SwiftUI, this package is brimming with utility functions that streamline and enhance your coding process.

## 🌟 Features:

- **Utility Functions**: Tackle common tasks effortlessly, from string manipulations to intricate date calculations.
  
- **SwiftUI Enhancements**: Power up your SwiftUI code with bespoke view modifiers, intuitive extensions, and other purpose-built utilities.
  
- **UIKit Boosters**: Engage with UIKit like never before. A rich set of extensions and helpers await that rekindle the magic of UIKit development.
  
- **Ready-to-Use Structs & Classes**: Common data structures? Patterns? We've got them curated for you.
  
- **Extensions Galore**: Amplify standard Swift types with a host of practical extensions that elevate their utility manifold.

## ✨ Why Choose IGSwiftUtilitiesKit?

The essence of development lies in innovation and reusability. With **IGSwiftUtilitiesKit**, we centralize the recurrent tasks and patterns, chopping off the boilerplate, and giving you more time to innovate. Whether it's a fresh SwiftUI project or a mature UIKit application, embedding **IGSwiftUtilitiesKit** is your ticket to a smoother, more efficient development experience.


# IGSwiftKeychain

IGSwiftKeychain is a Swift utility designed for a simplified and type-safe interaction with the iOS Keychain.

## Features

- **Type-safety**: Use Swift enums for your keychain keys.
- **Simplified API**: Store, retrieve, and delete with ease.
- **Swift Error Handling**: Uses the native `Error` protocol for better error handling.

## Installation

Install by pasting the GitHub repo URL in Xcode Package Manager, then follow the instructions. 

## Getting Started

### 1. Define your keys:

```swift
enum AppKeychainKeys: String, IGSwiftKeychainKey {
    case someSecret
    // Add more keys as needed
}
```

### 2. Initialize `IGSwiftKeychain`:

```swift
let keychain = IGSwiftKeychain<AppKeychainKeys>(service: "YourAppName")
```

### 3. Basic Usage

#### Save to Keychain:

```swift
do {
    try keychain.save("valueToSave", for: .someSecret)
} catch {
    print("Failed to save to keychain:", error)
}
```

#### Retrieve from Keychain:

```swift
do {
    let value = try keychain.get(.someSecret)
} catch {
    print("Failed to retrieve from keychain:", error)
}
```

#### Delete from Keychain:

```swift
do {
    try keychain.delete(.someSecret)
} catch {
    print("Failed to delete from keychain:", error)
}
```

## Contributing

Found a bug or have a feature suggestion? Please open an issue on GitHub. Contributions in the form of pull requests are also welcome.



//
//  IGBaseKeychainManager.swift
//  
//
//  Created by Øystein Günther on 16/09/2023.
//

import Foundation
import Combine

/// A protocol to define the types that can be used as keys for keychain operations.
protocol KeychainKey: RawRepresentable where RawValue == String {}

///
/// `Example of Subclassing`
///
/*
 // Define an enum for the specific keys you want to use in your subclass.
 enum MyAppKeychainKeys: String, IGKeychainKey {
     case userToken
     case lastLoginDate
 }

 // Create your subclass, inheriting from IGBaseKeychainManager.
 final class MyAppKeychainManager: IGBaseKeychainManager<MyAppKeychainKeys> {

     // Let's say you want to provide a custom method to fetch the user token.
     var userToken: String? {
         get { return self[.userToken] }
         set { self[.userToken] = newValue }
     }
     
     // You can also add additional functionality or properties in this subclass.
 }
 */
///
/// `Usage`
///
/*
 let myAppKeychain = MyAppKeychainManager(with: "com.myapp.service")

 // Set a value
 myAppKeychain.userToken = "sample_token_123"

 // Retrieve a value
 print(myAppKeychain.userToken ?? "No token found")

 */
/// A base class to manage keychain operations.
@available(macOS 10.15, *)
@available(iOS 13.0, *)
open class IGBaseKeychainManager<Key: IGKeychainKey> {
    
    /// Internal instance of `IGKeychainManager` configured with the specified service.
    internal let iGKeychainManager: IGKeychainManager<Key>
    
    /// Collection of cancellables to manage Combine subscriptions.
    internal var cancellables = Set<AnyCancellable>()

    /// Initializer to configure the manager with a specific service.
    /// - Parameter service: The service name to configure the keychain manager.
    required public init(with service: String) {
        iGKeychainManager = IGKeychainManager<Key>.configure(with: service)
    }

    /// Deletes all keys from the keychain.
    internal func deleteAllKeys() throws {
        try iGKeychainManager.deleteAllKeys()
    }

    /// Subscript for easier interaction with the keychain.
    /// Allows reading and writing values for specific keys.
    /// - Parameter key: The key for the value in the keychain.
    internal subscript(key: Key) -> String? {
        get {
            do {
                return try iGKeychainManager.getValue(for: key)
            } catch {
                IGDevLog.shared.error("Error retrieving \(key.rawValue): \(error)")
                return nil
            }
        }
        set {
            do {
                if let value = newValue {
                    try iGKeychainManager.setValue(value, for: key)
                } else {
                    try iGKeychainManager.delete(for: key)
                }
            } catch {
                IGDevLog.shared.error("Error setting/deleting \(key.rawValue): \(error)")
            }
        }
    }
}


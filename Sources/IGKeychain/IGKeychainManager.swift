//
//  IGKeychainManager.swift
//  
//
//  Created by Øystein Günther on 11/09/2023.
//

import Foundation
import Combine

/// A manager to interact with the keychain using a generic key type.
@available(macOS 10.15, *)
@available(iOS 13.0, *)
open class IGKeychainManager<Key: IGKeychainKey>: IGKeychainManagerProtocol {
    
    /// The keychain utility to save, retrieve, or delete items.
    private var keychain: IGKeychain<Key>
    
    /// A Combine subject to notify about changes in the keychain.
    public let changesSubject = PassthroughSubject<(Key, String?), Never>()

    /// Private initializer to ensure the KeychainManager is only instantiated using the `configure` method.
    /// - Parameter service: The service name for the keychain. Used to differentiate between different keychain items.
    private init(service: String) {
        self.keychain = IGKeychain<Key>(service: service)
    }
    
    /// Configures and returns an instance of the IGKeychainManager.
    /// - Parameter service: The service name for the keychain.
    /// - Returns: An instance of the KeychainManager.
    static public func configure(with service: String) -> IGKeychainManager<Key> {
        return IGKeychainManager(service: service)
    }
    
    /// Retrieves a value from the keychain for a given key.
    /// - Parameter key: The key to retrieve the value for.
    /// - Returns: The stored string value, or nil if not present.
    public func getValue(for key: Key) -> String? {
        return try? keychain.get(for: key)
    }
    
    /// Sets (or deletes) a value in the keychain for a given key.
    /// - Parameters:
    ///   - value: The value to store, or nil to delete.
    ///   - key: The key to associate the value with.
    public func setValue(_ value: String?, for key: Key) {
        if let val = value {
            try? keychain.save(val, for: key)
        } else {
            try? keychain.delete(for: key)
        }
        changesSubject.send((key, value))
    }
    
    /// Deletes a given key.
    /// - Parameters:
    ///   - key: The key to associate the value with.
    public func delete(for key: Key) {
        try? keychain.delete(for: key)
    }
    
    /// Deletes all keys and their associated values from the keychain.
    /// - Throws: An error if the deletion process fails.
    public func deleteAllKeys() throws {
        try keychain.deleteAllKeys()
    }
}

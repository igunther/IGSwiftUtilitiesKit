//
//  IGKeychainProtocols.swift
//  
//
//  Created by Øystein Günther on 08/09/2023.
//

import Foundation
import Combine

public protocol IGKeychainKey {
    var rawValue: String { get }
}

public protocol IGKeychainProtocol {
    associatedtype Key: IGKeychainKey
    
    func save(_ value: String, for key: Key) throws
    func get(for key: Key) throws -> String?
    func delete(for key: Key) throws
    func deleteAllKeys() throws
}

/// Protocol that outlines the required methods and properties for the keychain manager.
protocol IGKeychainManagerProtocol {
    
    associatedtype Key: IGKeychainKey

    /// A Combine subject that notifies about changes in the keychain.
    @available(macOS 10.15, *)
    @available(iOS 13.0, *)
    var changesSubject: PassthroughSubject<(Key, String?), Never> { get }

    /// Retrieves a value from the keychain for a given key.
    /// - Parameter key: The key to retrieve the value for.
    /// - Returns: The stored string value, or nil if not present.
    func getValue(for key: Key) throws -> String?

    /// Sets (or deletes) a value in the keychain for a given key.
    /// - Parameters:
    ///   - value: The value to store, or nil to delete.
    ///   - key: The key to associate the value with.
    func setValue(_ value: String?, for key: Key) throws
    
    /// Deletes a given key.
    /// - Parameters:
    ///   - key: The key to associate the value with.
    func delete(for key: Key) throws

    /// Deletes all keys and their associated values from the keychain.
    /// - Throws: An error if the deletion process fails.
    func deleteAllKeys() throws
}

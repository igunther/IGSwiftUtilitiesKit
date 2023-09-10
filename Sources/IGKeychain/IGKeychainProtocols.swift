//
//  IGKeychainProtocols.swift
//  
//
//  Created by Øystein Günther on 08/09/2023.
//

import Foundation

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

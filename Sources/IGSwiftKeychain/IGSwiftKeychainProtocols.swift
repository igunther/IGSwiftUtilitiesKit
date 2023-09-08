//
//  IGSwiftKeychainProtocols.swift
//  
//
//  Created by Øystein Günther on 08/09/2023.
//

import Foundation

public protocol IGSwiftKeychainKey {
    var rawValue: String { get }
}

public protocol IGSwiftKeychainProtocol {
    associatedtype Key: IGSwiftKeychainKey
    
    func save(_ value: String, for key: Key) throws
    func get(for key: Key) throws -> String?
    func delete(for key: Key) throws
}

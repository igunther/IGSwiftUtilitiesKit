//
//  IGKeychain.swift
//  
//
//  Created by Øystein Günther on 08/09/2023.
//

import Foundation

public struct IGKeychain<K: IGKeychainKey>: IGKeychainProtocol {
    public typealias Key = K
    
    public let service: String
    
    public init(service: String) {
        self.service = service
    }
    
    public func save(_ value: String, for key: Key) throws {
        // Prepare the query to update existing items
        let updateQuery = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: key.rawValue
        ] as [String: Any]

        let updateAttributes = [
            kSecValueData as String: value.data(using: .utf8)!
        ] as [String: Any]

        // Try to update existing items
        var status = SecItemUpdate(updateQuery as CFDictionary, updateAttributes as CFDictionary)

        if status == errSecItemNotFound {
            // Item not found, so add it as a new item
            let addQuery = updateQuery.merging(updateAttributes) { _, new in new }
            status = SecItemAdd(addQuery as CFDictionary, nil)
        }

        guard status == errSecSuccess else {
            throw IGKeychainError.storeError(status: status)
        }
    }
    
    public func get(for key: Key) throws -> String? {
        let query = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: key.rawValue,
            kSecMatchLimit as String: kSecMatchLimitOne,
            kSecReturnData as String: true
        ] as [String: Any]
        
        var item: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &item)
        guard status == errSecSuccess else {
            if status == errSecItemNotFound {
                return nil
            } else {
                throw IGKeychainError.retrieveError(status: status)
            }
        }
        
        guard let data = item as? Data, let value = String(data: data, encoding: .utf8) else {
            throw IGKeychainError.dataError
        }
        
        return value
    }
    
    public func delete(for key: Key) throws {
        let query = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: key.rawValue
        ] as [String: Any]
        
        let status = SecItemDelete(query as CFDictionary)
        guard status == errSecSuccess || status == errSecItemNotFound else {
            throw IGKeychainError.deleteError(status: status)
        }
    }
    
}



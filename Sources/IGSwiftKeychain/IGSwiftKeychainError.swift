//
//  IGSwiftKeychainError.swift
//  
//
//  Created by Øystein Günther on 08/09/2023.
//

import Foundation

public enum IGSwiftKeychainError: Error {
    case storeError(status: OSStatus)
    case retrieveError(status: OSStatus)
    case dataError
    case deleteError(status: OSStatus)
}


//
//  IGFileUtilityProtocol.swift
//  
//
//  Created by Øystein Günther on 10/09/2023.
//

import Foundation

/// A protocol that describes file utility operations.
public protocol IGFileUtilityProtocol {
    
    /// Creates an empty file if it doesn't already exist.
    ///
    /// - Parameter filename: The name of the file to be created.
    /// - Throws: An error if the file cannot be created.
    func createEmptyFileIfNotExists(filename: String) throws
    
    /// Checks if a file exists at the specified filename.
    ///
    /// - Parameter filename: The name of the file to be checked.
    /// - Returns: `true` if the file exists, otherwise `false`.
    func fileExists(filename: String) -> Bool
    
    /// Removes a file if it exists.
    ///
    /// - Parameter filename: The name of the file to be removed.
    /// - Throws: An error if the file cannot be removed.
    func removeFileIfExists(filename: String) throws
}



//
//  IGFileUtility.swift
//  
//
//  Created by Øystein Günther on 10/09/2023.
//

import Foundation

/// A utility class to provide convenient methods for common file operations.
public class IGFileUtility: IGFileUtilityProtocol {
    
    /// Returns the documents directory URL.
    private func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    /// Creates an empty file if it doesn't already exist.
    ///
    /// - Parameter filename: The name of the file to be created.
    /// - Throws: An error if the file cannot be created.
    public func createEmptyFileIfNotExists(filename: String) throws {
        let fileURL = getDocumentsDirectory().appendingPathComponent(filename)
        
        if !FileManager.default.fileExists(atPath: fileURL.path) {
            do {
                try "".write(to: fileURL, atomically: true, encoding: .utf8)
            } catch {
                throw error
            }
        }
    }
    
    /// Checks if a file exists at the specified filename.
    ///
    /// - Parameter filename: The name of the file to be checked.
    /// - Returns: `true` if the file exists, otherwise `false`.
    public func fileExists(filename: String) -> Bool {
        let fileURL = getDocumentsDirectory().appendingPathComponent(filename)
        return FileManager.default.fileExists(atPath: fileURL.path)
    }
    
    /// Removes a file if it exists.
    ///
    /// - Parameter filename: The name of the file to be removed.
    /// - Throws: An error if the file cannot be removed.
    public func removeFileIfExists(filename: String) throws {
        let fileURL = getDocumentsDirectory().appendingPathComponent(filename)
        
        if FileManager.default.fileExists(atPath: fileURL.path) {
            do {
                try FileManager.default.removeItem(at: fileURL)
            } catch {
                throw error
            }
        }
    }
}

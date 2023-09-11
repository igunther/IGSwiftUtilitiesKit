//
//  IGDate.swift
//  
//
//  Created by Øystein Günther on 11/09/2023.
//

import Foundation

extension Date {
    /// Converts Date into a formatted string based on the date format.
    func toString(using formatter: DateFormatter) -> String {
        return formatter.string(from: self)
    }
}


//
//  IGDevLog.swift
//  
//
//  Created by Øystein Günther on 11/09/2023.
//

import Foundation

/// Custom function wrapping Swift.print() to avoid confusion with Swift's built-in print.
/// This might prevent some security vulnerabilities.
/// - Parameter object: The object to be logged.
func devPrint(_ object: Any) {
    Swift.print(object)
}

/// A protocol that represents logging functionalities. It abstracts the functionalities of the logging class.
public protocol IGDevLogProtocol {
    func verbose(_ object: Any, filename: String, line: Int, column: Int, funcName: String)
    func debug(_ object: Any, filename: String, line: Int, column: Int, funcName: String)
    func info(_ object: Any, filename: String, line: Int, column: Int, funcName: String)
    func warning(_ object: Any, filename: String, line: Int, column: Int, funcName: String)
    func error(_ object: Any, filename: String, line: Int, column: Int, funcName: String)
    func garbage(_ object: Any, filename: String, line: Int, column: Int, funcName: String)
}

/// A logging class that provides different levels of logging with contextual information.
final public class IGDevLog: IGDevLogProtocol {
    
    /// Enum representing different log event types. Each type is associated with a specific emoji for visual identification.
    enum IGDevLogEvent: String {
        case verbose = "🧾"
        case debug = "🐵"
        case info = "💬"
        case warning = "⚠️"
        case error = "🔥"
        case garbage = "🗑"
    }
    
    /// Singleton instance for the logger. Ensures that the logger can be accessed throughout the application.
    public static var shared = IGDevLog()
    
    /// DateFormatter to format the date in logs.
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        formatter.locale = Locale.current
        formatter.timeZone = TimeZone.current
        return formatter
    }
    
    /// The chosen date format for the log timestamp.
    private var dateFormat: String
    
    /// A flag that determines whether logging is enabled or not.
    private var isLoggingEnabled: Bool
    
    /// A flag that determines wheter to include the 'IGDevLog' name in the log output.
    /// This can be useful when debugging in Xcode. Specifying 'IGDevLog' as a Filter
    /// in the debug area, will effectively filter out any other clutter.
    private var includeSelfClassName: Bool
    
    /// Private initializer to ensure the IGDevLog is only instantiated through the shared instance.
    private init(dateFormat: String = "HH:mm:ss.SSS", loggingEnabled: Bool = true, includeSelfClassName: Bool = false) {
        self.dateFormat = dateFormat
        self.isLoggingEnabled = loggingEnabled
        self.includeSelfClassName = includeSelfClassName
    }
    
    /// Configuration function to set up the logger.
    public static func configure(dateFormat: String = "HH:mm:ss.SSS", loggingEnabled: Bool = true) {
        shared.dateFormat = dateFormat
        shared.isLoggingEnabled = loggingEnabled
    }
    
    public func verbose(_ object: Any, filename: String = #file, line: Int = #line, column: Int = #column, funcName: String = #function) {
        log(object, eventType: .verbose, filename: filename, line: line, column: column, funcName: funcName)
    }
    
    public func debug(_ object: Any, filename: String = #file, line: Int = #line, column: Int = #column, funcName: String = #function) {
        log(object, eventType: .debug, filename: filename, line: line, column: column, funcName: funcName)
    }
    
    public func info(_ object: Any, filename: String = #file, line: Int = #line, column: Int = #column, funcName: String = #function) {
        log(object, eventType: .info, filename: filename, line: line, column: column, funcName: funcName)
    }
    
    public func warning(_ object: Any, filename: String = #file, line: Int = #line, column: Int = #column, funcName: String = #function) {
        log(object, eventType: .warning, filename: filename, line: line, column: column, funcName: funcName)
    }
    
    public func error(_ object: Any, filename: String = #file, line: Int = #line, column: Int = #column, funcName: String = #function) {
        log(object, eventType: .error, filename: filename, line: line, column: column, funcName: funcName)
    }
    
    public func garbage(_ object: Any, filename: String = #file, line: Int = #line, column: Int = #column, funcName: String = #function) {
        log(object, eventType: .garbage, filename: filename, line: line, column: column, funcName: funcName)
    }
    
    /// General log function that performs the actual logging.
    private func log(_ object: Any, eventType: IGDevLogEvent, filename: String, line: Int, column: Int, funcName: String) {
        if isLoggingEnabled {
            let date = Date().toString(using: dateFormatter)
            let className = String(describing: type(of: self)) + " ::"
            let prefix = includeSelfClassName ? className : ""
            devPrint("\(prefix) \(date) \(eventType.rawValue) \(sourceFileName(filePath: filename)):\(line) \(column) \(funcName) -> \(object)")
        }
    }
    
    /// Helper function to extract the file name from a file path.
    private func sourceFileName(filePath: String) -> String {
        let components = filePath.components(separatedBy: "/")
        return components.isEmpty ? "" : components.last!
    }
}

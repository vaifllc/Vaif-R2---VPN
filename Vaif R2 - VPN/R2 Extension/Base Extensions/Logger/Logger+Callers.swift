//
//  Logger+Callers.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 9/28/22.
//

import Logging

// Only levels that we actually use are added here
extension Logging.Logger {
    
    public func debug(_ message: @autoclosure () -> Message,
                      category: Logger.Category? = nil,
                      event: Logger.Event? = nil,
                      metadata: @autoclosure @escaping () -> Metadata? = nil,
                      source: @autoclosure () -> String? = nil,
                      file: String = #file, function: String = #function, line: UInt = #line) {
        
        self.log(level: .debug, message(), metadata: getMeta(metadata, category: category, event: event)(), source: source(), file: file, function: function, line: line)
    }
    
    public func info(_ message: @autoclosure () -> Message,
                     category: Logger.Category? = nil,
                     event: Logger.Event? = nil,
                     metadata: @autoclosure @escaping () -> Metadata? = nil,
                     source: @autoclosure () -> String? = nil,
                     file: String = #file, function: String = #function, line: UInt = #line) {
        
        self.log(level: .info, message(), metadata: getMeta(metadata, category: category, event: event)(), source: source(), file: file, function: function, line: line)
    }
    
    public func warning(_ message: @autoclosure () -> Message,
                        category: Logger.Category? = nil,
                        event: Logger.Event? = nil,
                        metadata: @autoclosure @escaping () -> Metadata? = nil,
                        source: @autoclosure () -> String? = nil,
                        file: String = #file, function: String = #function, line: UInt = #line) {
        
        self.log(level: .warning, message(), metadata: getMeta(metadata, category: category, event: event)(), source: source(), file: file, function: function, line: line)
    }
    
    public func error(_ message: @autoclosure () -> Message,
                      category: Logger.Category? = nil,
                      event: Logger.Event? = nil,
                      metadata: @autoclosure @escaping () -> Metadata? = nil,
                      source: @autoclosure () -> String? = nil,
                      file: String = #file, function: String = #function, line: UInt = #line) {
        
        self.log(level: .error, message(), metadata: getMeta(metadata, category: category, event: event)(), source: source(), file: file, function: function, line: line)
    }
    
    /// Metadata predefined keys
    public enum MetaKey: String {
        case category
        case event
    }
    
    /// Add our own category and event into metada data
    private func getMeta(_ originalMetadata: @escaping () -> Metadata?, category: Logger.Category? = nil, event: Logger.Event? = nil) -> (() -> Metadata?) {
        return {
            var res: Metadata = originalMetadata() ?? Metadata()
            if let category = category {
                res[MetaKey.category.rawValue] = .string(category.rawValue)
            }
            if let event = event {
                res[MetaKey.event.rawValue] = .string(event.rawValue)
            }
            return res
        }
    }
    
}

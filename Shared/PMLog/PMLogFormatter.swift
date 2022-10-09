//
//  PMLogFormatter.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 10/9/22.
//

import Logging
import Foundation

public protocol PMLogFormatter {
    func formatMessage(_ level: Logging.Logger.Level, message: String, function: String, file: String, line: UInt, metadata: [String: String], date: Date) -> String // swiftlint:disable:this function_parameter_count
}

// `Logging.` has to be prepended in some cases because this file is also included in WireGuard extension, which has its own `Logger` class.
extension PMLogFormatter {
    /// Extract category and  event from metada. Return metadata without extracted elements.
    func extract(metadata: [String: String]) -> (String, String, [String: String]) { // swiftlint:disable:this large_tuple
        let category = metadata[Logging.Logger.MetaKey.category.rawValue] != nil ? "\(metadata[Logging.Logger.MetaKey.category.rawValue]!)" : ""
        let event = metadata[Logging.Logger.MetaKey.event.rawValue] != nil ? ":\(metadata[Logging.Logger.MetaKey.event.rawValue]!)" : ""
        
        let keysToRemove = [Logging.Logger.MetaKey.category.rawValue, Logging.Logger.MetaKey.event.rawValue]
        let metaClean = metadata.filter { key, value in !keysToRemove.contains(key) }
        
        return (category, event, metaClean)
    }
}


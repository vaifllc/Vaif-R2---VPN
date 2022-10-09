//
//  FileLogFormatter.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 10/9/22.
//

import Foundation
import Logging

public class FileLogFormatter: PMLogFormatter {
    
    internal let dateFormatter = ISO8601DateFormatter()
    private let jsonEncoder = JSONEncoder()

    public init() {
        dateFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
    }
    
    public func formatMessage(_ level: Logging.Logger.Level, message: String, function: String, file: String, line: UInt, metadata: [String: String], date: Date) -> String {// swiftlint:disable:this function_parameter_count
        let dateTime = dateFormatter.string(from: date)
        let (category, event, meta) = extract(metadata: metadata)
        var metaString = ""
        if !meta.isEmpty, let metaJsonData = try? jsonEncoder.encode(meta) {
            metaString = String(data: metaJsonData, encoding: .utf8) ?? ""
        }
        return "\(dateTime) | \(level.stringValue) | \(category.uppercased())\(event.uppercased()) | \(message) | \(metaString)"
    }
    
}


//
//  OSLogFormatter.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 10/12/22.
//

import Foundation
import Logging

public class OSLogFormatter: PMLogFormatter {

    private let jsonEncoder = JSONEncoder()

    public init() {
    }

    public func formatMessage(_ level: Logging.Logger.Level, message: String, function: String, file: String, line: UInt, metadata: [String: String], date: Date) -> String {// swiftlint:disable:this function_parameter_count
        let (category, event, meta) = extract(metadata: metadata)
        var metaString = ""
        if !meta.isEmpty, let metaJsonData = try? jsonEncoder.encode(meta) {
            metaString = String(data: metaJsonData, encoding: .utf8) ?? ""
        }
        #if DEBUG
        let prepend = "\(level.emoji) \(level.stringValue) | "
        #else
        let prepend = ""
        #endif
        return "\(prepend)\(category.uppercased())\(event.uppercased()) | \(message) | \(metaString)"
    }

}


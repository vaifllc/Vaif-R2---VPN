//
//  Logger+Main.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 10/9/22.
//

import Foundation
import OSLog
import Logging

/// Main logger instance that should be used
public let log: Logging.Logger = Logging.Logger(label: "ProtonVPN.logger")

extension Logging.Logger {
    public static func instance(withCategory category: Logging.Logger.Category) -> Logging.Logger {
        var logger: Logging.Logger = Logging.Logger(label: "ProtonVPN.logger.\(category.rawValue)")
        logger[metadataKey: Logging.Logger.MetaKey.category.rawValue] = .string(category.rawValue)
        return logger
    }
}


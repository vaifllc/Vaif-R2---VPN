//
//  Level+Print.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 10/9/22.
//

import Logging

extension Logging.Logger.Level {
    public var emoji: String {
        switch self {
        case .trace:
            return "⚪"
        case .debug:
            return "🟢"
        case .info:
            return "🔵"
        case .notice:
            return "🟠"
        case .warning:
            return "🟡"
        case .error:
            return "🔴"
        case .critical:
            return "💥"
        }
    }

    var stringValue: String {
        switch self {
        case .trace:
            return "TRACE"
        case .debug:
            return "DEBUG"
        case .info:
            return "INFO "
        case .notice:
            return "NOTIC"
        case .warning:
            return "WARN "
        case .error:
            return "ERROR"
        case .critical:
            return "FATAL"
        }
    }
}


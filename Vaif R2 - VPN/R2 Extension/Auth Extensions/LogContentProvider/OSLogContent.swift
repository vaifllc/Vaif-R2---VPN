//
//  OSLogContent.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 9/30/22.
//

import Foundation
import OSLog

@available(iOS 15, macOS 12, *)
class OSLogContent: LogContent {

    private let dateFormatter = ISO8601DateFormatter()

    func loadContent(callback: @escaping (String) -> Void) {
        DispatchQueue.global(qos: .userInitiated).async {
            do {
                let dateFormatter = ISO8601DateFormatter()
                dateFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
                let store = try OSLogStore(scope: .currentProcessIdentifier)
                let position = store.position(timeIntervalSinceLatestBoot: 1)
                let entries = try store.getEntries(at: position)
                    .compactMap { $0 as? OSLogEntryLog }
                    .filter { $0.subsystem == "vAIF-R2" }
                    .map { "\(dateFormatter.string(from: $0.date)) | \($0.level.stringValue.uppercased()) | \($0.composedMessage)" }
                let result = entries.joined(separator: "\n")
                callback(result)

            } catch {
                callback("")
            }
        }
    }
}

@available(iOS 15, macOS 12, *)
extension OSLogEntryLog.Level {
    var stringValue: String {
        switch self {
        case .undefined:
            return "Debug"
        case .debug:
            return "Debug"
        case .info:
            return "Info"
        case .notice:
            return "Notice"
        case .error:
            return "Error"
        case .fault:
            return "Fatal"
        }
    }
}


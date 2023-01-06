//
//  Date+Misc.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 10/4/22.
//

import Foundation

public extension Date {
    
    private static let logFormat = "yyyy-MM-dd HH:mm:ss"
    private static let fileNameFormat = "yyyy-MM-dd-HHmmss"
    private static let dateFormat = "yyyy-MM-dd"
    private static let dateTimeFormat = "yyyy-MM-dd HH:mm"
    
    static func logTime() -> String {
        return formatted(format: logFormat)
    }
    
    static func logFileName(prefix: String = "") -> String {
        return "\(prefix)\(formatted(format: fileNameFormat))"
    }
    
    static func changeDays(by days: Int) -> Date {
        var dateComponents = DateComponents()
        dateComponents.day = days
        return Calendar.current.date(byAdding: dateComponents, to: Date())!
    }
    
    static func changeMinutes(by minutes: Int) -> Date {
        var dateComponents = DateComponents()
        dateComponents.minute = minutes
        return Calendar.current.date(byAdding: dateComponents, to: Date())!
    }
    
    func changeDays(by days: Int) -> Date {
        var dateComponents = DateComponents()
        dateComponents.day = days
        return Calendar.current.date(byAdding: dateComponents, to: self)!
    }
    
    func changeMinutes(by minutes: Int) -> Date {
        var dateComponents = DateComponents()
        dateComponents.minute = minutes
        return Calendar.current.date(byAdding: dateComponents, to: self)!
    }
    
    func formatDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = Date.dateFormat
        return formatter.string(from: self)
    }
    
    func formatDateTime() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = Date.dateTimeFormat
        return formatter.string(from: self)
    }
    
    private static func formatted(format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: Date())
    }
    
    /// Check if this date represnt time in future
    var isFuture: Bool {
        return self.timeIntervalSinceNow > 0
    }
    
    /// Check if this date represnt time in future
    var isPast: Bool {
        return self.timeIntervalSinceNow < 0
    }
}


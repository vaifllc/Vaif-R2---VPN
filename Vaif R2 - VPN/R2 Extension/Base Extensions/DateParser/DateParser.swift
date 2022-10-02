//
//  DateParser.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 9/29/22.
//

import Foundation

public enum DateParser {
    
    /// locale code
    enum LocaleCode: String {
        case en_us = "en_US_POSIX"
    }
    
    /// date format
    enum LocaleFormat: String {
        case en_us = "EEE, dd MMM yyyy HH:mm:ss zzz"
    }
    
    /// convert a string datetime to a Date object
    ///   notes::if seeing more failure, we can try to use ISO8601DateFormatter() as a fallback
    /// - Parameter serverDate: server response header Date field
    /// - Returns: parsed date
    public static func parse(time serverDate: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.calendar = .some(.init(identifier: .gregorian))
        /// default locale must be set. use en_US matches with server response time
        dateFormatter.locale = Locale(identifier: LocaleCode.en_us.rawValue)
        /// dataformat is depends on server response. it shoude always like: "EEE, dd MMM yyyy HH:mm:ss zzz"
        dateFormatter.dateFormat = LocaleFormat.en_us.rawValue
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        return dateFormatter.date(from: serverDate)
    }
}

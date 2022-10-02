//
//  TimeInterval+Extension.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 9/28/22.
//

import Foundation

public extension TimeInterval {
    static func minutes(_ minutes: Int) -> Self {
        Self(minutes) * 60
    }

    static func hours(_ hours: Int) -> Self {
        Self(hours) * .minutes(60)
    }

    static func days(_ days: Int) -> Self {
        Self(days) * .hours(24)
    }

    // swiftlint:disable large_tuple
    var components: (days: Int, hours: Int, minutes: Int, seconds: Int) {
        let days = Int(self) / (60 * 60 * 24)
        let hours = Int(self) / (60 * 60) % 24
        let minutes = Int(self) / 60 % 60
        let seconds = Int(self) % 60

        return (days, hours, minutes, seconds)
    }
    // swiftlint:enable large_tuple

    var asColonSeparatedString: String {
        let time = components
        if time.days > 0 {
            return String(format: "%02i:%02i:%02i:%02i",
                          time.days, time.hours, time.minutes, time.seconds)
        } else {
            return String(format: "%02i:%02i:%02i",
                          time.hours, time.minutes, time.seconds)
        }
    }
}


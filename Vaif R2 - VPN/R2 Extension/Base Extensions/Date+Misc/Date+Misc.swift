//
//  Date+Misc.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 10/4/22.
//

import Foundation

public extension Date {
    
    /// Check if this date represnt time in future
    var isFuture: Bool {
        return self.timeIntervalSinceNow > 0
    }
    
    /// Check if this date represnt time in future
    var isPast: Bool {
        return self.timeIntervalSinceNow < 0
    }
}


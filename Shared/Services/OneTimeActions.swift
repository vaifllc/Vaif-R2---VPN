//
//  OneTimeActions.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 9/18/22.
//

import Foundation

enum OneTimeActions {
    
    enum Flag: String {
        case notificationAuthorizationRequestPopup = "VaifR2VPNHasSeenNotificationAuthorizationRequestPopup"
        case oneHundredTrackingAttemptsBlockedNotification = "VaifR2VPNHasScheduledOneHundredTrackingAttemptsBlockedNotification"
    }
    
    static func hasSeen(_ flag: Flag) -> Bool {
        return defaults.bool(forKey: flag.rawValue)
    }
    
    static func markAsSeen(_ flag: Flag) {
        defaults.set(true, forKey: flag.rawValue)
    }
    
    static func performOnce(ifHasNotSeen flag: Flag, action: () -> ()) {
        if hasSeen(flag) {
            return
        } else {
            markAsSeen(flag)
            action()
        }
    }
}


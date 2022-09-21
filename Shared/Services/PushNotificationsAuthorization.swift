//
//  PushNotificationsAuthorization.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 9/18/22.
//

import UIKit
import UserNotifications
import CocoaLumberjackSwift

extension PushNotifications {
    
    enum Authorization {
        
        static let kUserAuthorizedPrefix = "Vaif R2: NotificationsUserAuthorizedCategory"
                
        enum Status {
            case authorized
            case notAuthorized
        }
                
        static func getUserWantsNotificationsEnabled(forCategory category: PushNotifications.Category) -> Bool {
            return defaults.bool(forKey: kUserAuthorizedPrefix + category.rawValue)
        }
        
        static func getUserWantsNotificationsEnabledForAnyCategory() -> Bool {
            return getUserWantsNotificationsEnabled(forCategory: .weeklyUpdate)
        }
        
        static func setUserWantsNotificationsEnabled(_ userWantsNotificationsEnabled: Bool, forCategory category: PushNotifications.Category) {
            defaults.set(userWantsNotificationsEnabled, forKey: kUserAuthorizedPrefix + category.rawValue)
            if category == .weeklyUpdate {
                if userWantsNotificationsEnabled {
                    PushNotifications.shared.userDidAuthorizeWeeklyUpdate()
                } else {
                    DDLogInfo("Weekly updates notifications are turned off; removing all pending notifications")
                    PushNotifications.shared.removeAllPendingNotifications()
                }
            }
        }
    }
}


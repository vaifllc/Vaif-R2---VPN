//
//  UserActivityType.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 12/27/22.
//

import Foundation

enum UserActivityType {
    static let Connect = "vaif.Vaif-R2---VPN.Connect"
    static let Disconnect = "vaif.Vaif-R2---VPN.Disconnect"
    static let AntiTrackerEnable = "vaif.Vaif-R2---VPN.AntiTracker.enable"
    static let AntiTrackerDisable = "vaif.Vaif-R2---VPN.AntiTracker.disable"
    static let CustomDNSEnable = "vaif.Vaif-R2---VPN.CustomDNS.enable"
    static let CustomDNSDisable = "vaif.Vaif-R2---VPN.CustomDNS.disable"
}

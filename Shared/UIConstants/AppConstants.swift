//
//  AppConstants.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 9/27/22.
//

import Foundation
import UIKit

class AppConstants {

    static var appBundleId: String = (Bundle.main.bundleIdentifier ?? "ch.protonmail.vpn").asMainAppBundleIdentifier
    
    struct AppGroups {
        static let main = "group.ch.protonmail.vpn"
    }
    
    struct NetworkExtensions {
        static let openVpn = "\(appBundleId).OpenVPN-Extension"
        static let wireguard = "\(appBundleId).WireGuardiOS-Extension"
    }
    
    struct Time {
        // Connection stuck timming
        static let waitingTimeForConnectionStuck: Double = 3
        static let timeForForegroundStuck: Double = 30 * 60 // 30 minutes

        // Servers list refresh
        static let fullServerRefresh: TimeInterval = 3600 * 3 // 3 hours
        static let serverLoadsRefresh: TimeInterval = 60 * 15 // 15 minutes
        
        // Account
        static let userAccountRefresh: TimeInterval = 60 * 3  // 3 minutes
        
        // Payments
        static let paymentTokenLifetime: TimeInterval = 60 * 59 // 59 minutes
    }
    
    struct Filenames {
        static let appLogFilename = "ProtonVPN.log"
    }
}

extension String {
    var asMainAppBundleIdentifier: String {
        var result = self.replacingOccurrences(of: ".widget", with: "")
        result = result.replacingOccurrences(of: ".Siri-Shortcut-Handler", with: "")
        result = result.replacingOccurrences(of: ".OpenVPN-Extension", with: "")
        result = result.replacingOccurrences(of: ".WireGuardiOS-Extension", with: "")
        return result
    }
}

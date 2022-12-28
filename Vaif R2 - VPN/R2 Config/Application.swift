//
//  Application.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 12/27/22.
//

import Foundation
import NetworkExtension

class Application {
    
    // MARK: - Properties -
    
    static var shared = Application()
    
    
    
    var status: NEVPNStatus = .invalid {
        didSet {
            UserDefaults.shared.set(status.rawValue, forKey: UserDefaults.Key.connectionStatus)
        }
    }
    
    
    var network = Network(context: StorageManager.context, needToSave: false) {
        didSet {
            NotificationCenter.default.post(name: Notification.Name.UpdateNetwork, object: nil)
        }
    }
    
    var geoLookup = GeoLookup(ipAddress: "", countryCode: "", country: "", city: "", isIvpnServer: false, isp: "", latitude: 0, longitude: 0)
    
    // MARK: - Initialize -
    
}

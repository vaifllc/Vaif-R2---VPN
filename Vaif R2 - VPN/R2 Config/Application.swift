//
//  Application.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 12/27/22.
//

import Foundation

class Application {
    
    // MARK: - Properties -
    
    static var shared = Application()
    
    //var authentication: Authentication
    //var connectionManager: ConnectionManager
    
    
    
    var connectionManager: ConnectionManager
    
    var settings: R1Settings {
        didSet {
            connectionManager.settings = settings
        }
    }
    
    var serverList: VPNServerList {
        didSet {
            settings = R1Settings(serverList: serverList)
        }
    }
    
    var serviceStatus: ServiceStatus {
        didSet {
            serviceStatus.save()
        }
    }
    
    var network = Network(context: StorageManager.context, needToSave: false) {
        didSet {
            NotificationCenter.default.post(name: Notification.Name.UpdateNetwork, object: nil)
        }
    }
    
    var geoLookup = GeoLookup(ipAddress: "", countryCode: "", country: "", city: "", isIvpnServer: false, isp: "", latitude: 0, longitude: 0)
    
    // MARK: - Initialize -
    
    private init() {
        serverList = VPNServerList()
        serviceStatus = ServiceStatus()
//        authentication = Authentication()
        settings = R1Settings(serverList: serverList)
        connectionManager = ConnectionManager(settings: settings, vpnManager: VPNManager2())
    }
    
    // MARK: - Methods -
    
    func clearSession() {
        serviceStatus.isActive = false
    }
    
}

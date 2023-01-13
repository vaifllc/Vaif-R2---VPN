//
//  VPNServerViewModel.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 1/2/23.
//


import UIKit

struct VPNServerViewModel {
    
    // MARK: - Properties -
    
    var server: ServerModel
    var selectedHost: Host?
    
    var textInPlaceOfConnectIcon: String? {
        return "UPGRADE" 
    }
    
    
    var imageNameForPingTimeForMainScreen: String {
        if server.randomServerLabelShouldBePresented {
            return ""
        }
        
        return imageNameForPingTime
    }
    
    var formattedServerNameForMainScreen: String {
        if server.randomServerLabelShouldBePresented {
            return "Random server"
        }
        
        if let selectedHost = selectedHost {
            let hostNameComponents = selectedHost.hostName.components(separatedBy: ".")
            return "\(server.state) (\(hostNameComponents[0])), \(server.countryCode.uppercased())"
        }
        
        return formattedServerName
    }
    
    var imageForCountryCodeForMainScreen: UIImage? {
        if server.randomServerLabelShouldBePresented {
            let image = UIImage(named: "icon-shuffle")
            image?.accessibilityIdentifier = "icon-shuffle"
            return image
        }
        
        return UIImage(named: server.countryCode.uppercased())
    }
    
    var formattedServerNameForSettings: String {
        if server.fastest && !UserDefaults.shared.isMultiHop {
            return "Fastest server"
        }
        
        if server.random {
            return "Random server"
        }
        
        if let selectedHost = selectedHost {
            let hostNameComponents = selectedHost.hostName.components(separatedBy: ".")
            return "\(server.state) (\(hostNameComponents[0])), \(server.countryCode.uppercased())"
        }
        
        return formattedServerName
    }
    
    var imageForCountryCodeForSettings: UIImage? {
        if server.fastest && !UserDefaults.shared.isMultiHop {
            let image = UIImage(named: "icon-fastest-server")
            image?.accessibilityIdentifier = "icon-fastest-server"
            return image
        }
        
        if server.random {
            let image = UIImage(named: "icon-shuffle")
            image?.accessibilityIdentifier = "icon-shuffle"
            return image
        }
        
        return UIImage(named: server.countryCode.uppercased())
    }
    
    var imageNameForPingTime: String {
        guard let pingMs = server.pingMs else { return "" }
        if pingMs >= 0 && pingMs < 100 { return "icon-circle-green" }
        if pingMs >= 100 && pingMs < 300 { return "icon-circle-orange" }
        return "icon-circle-red"
    }
    
    var formattedServerName: String {
//        if server.isHost {
//            return server.gateway
//        }
        
        return "\(server.state), \(server.countryCode.uppercased())"
    }
    
    var imageForCountryCode: UIImage? {
        return UIImage(named: server.countryCode.uppercased())
    }
    
    var imageNameForCountryCode: String {
        return server.countryCode.uppercased()
    }
    
    var imageForPingTime: UIImage? {
        guard server.pingMs != nil else {
            return nil
        }
        
        return UIImage(named: imageNameForPingTime)
    }
    
    var showIPv6Label: Bool {
        return UserDefaults.standard.showIPv4Servers && UserDefaults.shared.isIPv6 && server.enabledIPv6 && !(server.random && Application.shared.connectionManager.status.isDisconnected())
    }
    
    // MARK: - Initialize -
    
    init(server: ServerModel, selectedHost: Host? = nil) {
        self.server = server
        self.selectedHost = selectedHost
    }
    
    // MARK: - Methods -
    
    func formattedServerName(sort: ServersSort) -> String {
        guard sort != .country else {
            return "\(server.countryCode.uppercased()), \(server.state)"
        }
        
        return "\(server.state), \(server.countryCode.uppercased())"
    }
    
}


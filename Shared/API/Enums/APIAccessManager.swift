//
//  APIAccessManager.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 1/4/23.
//

import Foundation

class APIAccessManager {
    
    // MARK: - Properties -
    
    static let shared = APIAccessManager()
    
    var ipv4HostName: String? {
        return UserDefaults.shared.hostNames.first
    }
    
    var ipv6HostName: String? {
        return UserDefaults.shared.ipv6HostNames.first
    }
    
    private var hostNames: [String] {
        var hosts = hostNamesCollection
        hosts.move(UserDefaults.shared.apiHostName, to: 0)
        return hosts
    }
    
    private var hostNamesCollection: [String] {
        return [R2Config.ApiHostName] + UserDefaults.shared.hostNames + UserDefaults.shared.ipv6HostNames
    }
    
    // MARK: - Methods -
    
    func nextHostName(failedHostName: String, addressType: AddressType? = nil) -> String? {
        if let addressType = addressType {
            switch addressType {
            case .IPv4:
                return UserDefaults.shared.hostNames.next(item: failedHostName)
            case .IPv6:
                return UserDefaults.shared.ipv6HostNames.next(item: failedHostName)
            default:
                break
            }
        }
        
        return hostNames.next(item: failedHostName)
    }
    
}



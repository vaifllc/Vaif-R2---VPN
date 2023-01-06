//
//  Host.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 1/2/23.
//

import Foundation

struct IPv6: Codable {
    var localIP: String
}

struct Host: Codable {
    
    var host: String
    var hostName: String
    var publicKey: String
    var localIP: String
    var ipv6: IPv6?
    var multihopPort: Int
    var load: Double
    
    func localIPAddress() -> String {
        if let range = localIP.range(of: "/", options: .backwards, range: nil, locale: nil) {
            let ipString = localIP[..<range.lowerBound]
            return String(ipString)
        }
        
        return ""
    }
    
    func hostNamePrefix() -> String {
        let hostNameParts = hostName.components(separatedBy: ".")
        if let location = hostNameParts.first {
            return location
        }
        
        return ""
    }
    
    static func save(_ host: Host?, key: String) {
        if let host = host {
            if let encoded = try? JSONEncoder().encode(host) {
                UserDefaults.standard.set(encoded, forKey: key)
            }
        } else {
            UserDefaults.standard.removeObject(forKey: key)
        }
        UserDefaults.standard.synchronize()
    }
    
    static func load(key: String) -> Host? {
        if let saved = UserDefaults.standard.object(forKey: key) as? Data {
            if let loaded = try? JSONDecoder().decode(Host.self, from: saved) {
                return loaded
            }
        }
        
        return nil
    }
    
}


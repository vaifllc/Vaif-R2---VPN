//
//  ServerModel.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 12/16/22.
//

import Foundation
import NetworkExtension
import CoreLocation

public class ServerModel: NSObject {
    //MARK: - V1 Server Models
    var ipAddress: String = ""
    var ovpn: String = ""
    var ovpnName: String = ""
    var premium: Bool = false
    var recommend: Bool = false
    var state: String = ""
    var status: Bool = false
    var pingMs: Int?
    var status2: NEVPNStatus = .invalid {
        didSet {
            UserDefaults.standard.set(status2.rawValue, forKey: UserDefaults.Key.selectedServerStatus)
            UserDefaults.standard.synchronize()
        }
    }
    var fastest = false {
        didSet {
            UserDefaults.standard.set(fastest, forKey: UserDefaults.Key.selectedServerFastest)
            UserDefaults.standard.synchronize()
        }
    }
    var random = false
    var fastestServerLabelShouldBePresented: Bool {
        return fastest && pingMs == nil && Application.shared.connectionManager.status.isDisconnected()
    }
    var randomServerLabelShouldBePresented: Bool {
        return random && Application.shared.connectionManager.status.isDisconnected()
    }
    var location: CLLocation {
        return CLLocation(latitude: latitude, longitude: longitude)
    }
    var supportsIPv6: Bool {
        for host in hosts {
            if host.ipv6 == nil {
                return false
            }
        }
        
        return true
    }
    var enabledIPv6: Bool {
        for host in hosts {
            if !(host.ipv6?.localIP.isEmpty ?? true) {
                return true
            }
        }
        
        return false
    }
    var isHost: Bool {
        return country == "" && gateway != ""
    }
    var hostGateway: String {
        return gateway.components(separatedBy: CharacterSet.decimalDigits).joined()
    }
    private (set) var gateway: String
    private (set) var latitude: Double
    private (set) var longitude: Double
    private (set) var hosts: [Host]
    private (set) var load: Double?
    private (set) var ipAddresses: [String]
    private (set) var country: String
    private (set) var city: String
    private (set) var countryCode: String
    
    //MARK: - V2 Server Models
//    public let id: String
//    public let name: String
//    public let domain: String
//    public private(set) var load: Int
//    public let entryCountryCode: String // use when feature.secureCore is true
//    public let exitCountryCode: String
    public let tier: Int
//    public private(set) var score: Double
//    public private(set) var status: Int
//    public let feature: ServerFeature
//    public let city: String?
//    public var ips: [ServerIp] = []
//    public var location: ServerLocation
//    public let hostCountry: String?
//    public let translatedCity: String?
    
    

    

    //private (set) var state: String
    
    init(gateway: String, countryCode: String, country: String, city: String, latitude: Double = 0, longitude: Double = 0, ipAddresses: [String] = [], hosts: [Host] = [], fastest: Bool = false, load: Double = 0,tier: Int) {
        self.gateway = gateway
        self.countryCode = countryCode
        self.country = country
        self.city = city
        //self.state = state
        self.latitude = latitude
        self.longitude = longitude
        self.ipAddresses = ipAddresses
        self.hosts = hosts
        self.fastest = fastest
        self.load = load
        self.tier = tier
    }
    
    //    override init() {
    //        super.init()
    //    }
    
    public func matches(searchQuery: String) -> Bool {
        let query = searchQuery.lowercased()
        
        if ovpnName.lowercased().contains(query) {
            return true
        }
        
        if country.lowercased().contains(query) {
            return true
        }
        
        if state.lowercased().contains(query) {
            return true
        }
        
        
        return false
    }
    
    func getLocationFromGateway() -> String {
        let gatewayParts = gateway.components(separatedBy: ".")
        if let location = gatewayParts.first { return location }
        return ""
    }
    
    func distance(to location: CLLocation) -> CLLocationDistance {
        return location.distance(from: self.location)
    }
    
    func getHost(hostName: String) -> Host? {
        return hosts.first { $0.hostName == hostName }
    }
    
    func getHost(fromPrefix: String) -> Host? {
        return hosts.first { $0.hostName.hasPrefix(fromPrefix) }
    }
    
    static func == (lhs: ServerModel, rhs: ServerModel) -> Bool {
        return lhs.city == rhs.city && lhs.countryCode == rhs.countryCode
    }
    
    func initWith(data: [String: Any]) {
        if let country = data["country"] as? String {
            self.country = country
        }
        
        if let countryCode = data["countryCode"] as? String {
            self.countryCode = countryCode
        }
        
        if let ipAddress = data["ipAddress"] as? String {
            self.ipAddress = ipAddress
        }
        
        if let ovpn = data["ovpn"] as? String {
            self.ovpn = ovpn
        }
        
        if let ovpnName = data["ovpnName"] as? String {
            self.ovpnName = ovpnName
        }
        
        if let state = data["state"] as? String {
            self.state = state
        }
        
        if let premium = data["premium"] as? Bool {
            self.premium = premium
        }
        
        if let recommend = data["recommend"] as? Bool {
            self.recommend = recommend
        }
        
        if let status = data["status"] as? Bool {
            self.status = status
        }
    }
    
    func dictionary() -> [String: Any] {
        return ["country": self.country,
                "countryCode": self.countryCode,
                "ipAddress": self.ipAddress,
                "ovpn": self.ovpn,
                "ovpnName": self.ovpnName,
                "state": self.state,
                "premium": self.premium,
                "recommend": self.recommend,
                "status": self.status]
    }
}

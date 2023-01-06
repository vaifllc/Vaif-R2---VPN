//
//  ConnectionSettings.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 1/2/23.
//

import Foundation

enum ConnectionSettings {
    
    case ipsec
    case openvpn(OpenVPNProtocol, Int)
    case wireguard(WireGuardProtocol, Int)
    
    func format() -> String {
        if UserDefaults.shared.isMultiHop {
            return formatMultiHop()
        }
        
        switch self {
        case .ipsec:
            return "IKEv2"
        case .openvpn(let proto, let port):
            switch proto {
            case .tcp:
                return "OpenVPN, TCP \(port)"
            case .udp:
                return "OpenVPN, UDP \(port)"
           }
        case .wireguard(_, let port):
            return "WireGuard, UDP \(port)"
        }
    }
    
    func formatMultiHop() -> String {
        switch self {
        case .ipsec:
            return "IKEv2"
        case .openvpn(let proto, _):
            switch proto {
            case .tcp:
                return "OpenVPN, TCP"
            case .udp:
                return "OpenVPN, UDP"
           }
        case .wireguard:
            return "WireGuard, UDP"
        }
    }
    
    func formatSave() -> String {
        switch self {
        case .ipsec:
            return "ikev2"
        case .openvpn(let proto, let port):
            switch proto {
            case .tcp:
                return "openvpn-tcp-\(port)"
            case .udp:
                return "openvpn-udp-\(port)"
           }
        case .wireguard(_, let port):
            return "wireguard-udp-\(port)"
        }
    }
    
    func formatTitle() -> String {
        switch self {
        case .ipsec:
            return "IKEv2"
        case .openvpn:
            return "OpenVPN"
        case .wireguard:
            return "WireGuard"
        }
    }
    
    func formatProtocol() -> String {
        switch self {
        case .ipsec:
            return "IKEv2"
        case .openvpn(let proto, let port):
            switch proto {
            case .tcp:
                return "TCP \(port)"
            case .udp:
                return "UDP \(port)"
            }
        case .wireguard(_, let port):
            return "UDP \(port)"
        }
    }
    
   static func tunnelTypes(protocols: [ConnectionSettings]) -> [ConnectionSettings] {
        var filteredProtocols = [ConnectionSettings]()
        
        for protocolObj in protocols {
            var containsProtocol = false
            
            for filteredProtocol in filteredProtocols {
                if filteredProtocol.tunnelType() == protocolObj.tunnelType() {
                    containsProtocol = true
                }
            }
            
            if !containsProtocol {
                filteredProtocols.append(protocolObj)
            }
        }
        
        return filteredProtocols
    }
    
    func supportedProtocols(protocols: [ConnectionSettings]) -> [ConnectionSettings] {
        var filteredProtocols = [ConnectionSettings]()
        
        for protocolObj in protocols {
            if protocolObj.tunnelType() == self.tunnelType() {
                filteredProtocols.append(protocolObj)
            }
        }
        
        return filteredProtocols
    }
    
    func supportedProtocolsFormat(protocols: [ConnectionSettings]) -> [String] {
        let protocols = supportedProtocols(protocols: protocols)
        return protocols.map({ $0.formatProtocol() })
    }
    
    func supportedProtocolsFormatMultiHop() -> [String] {
        return ["UDP", "TCP"]
    }
    
    static func getSavedProtocol() -> ConnectionSettings {
        let portString = UserDefaults.standard.string(forKey: UserDefaults.Key.selectedProtocol) ?? ""
        return getFrom(portString: portString)
    }
    
    static func getFrom(portString: String) -> ConnectionSettings {
        var name = ""
        var proto = ""
        var port = 0
        let components = portString.components(separatedBy: "-")
        
        if let protocolName = components[safeIndex: 0] {
            name = protocolName
        }
        if let protocolType = components[safeIndex: 1] {
            proto = protocolType
        }
        if let protocolPort = components[safeIndex: 2] {
            port = Int(protocolPort) ?? 0
        }
        
        switch name {
        case "ikev2":
            return .ipsec
        case "openvpn":
            switch proto {
            case "tcp":
                return .openvpn(.tcp, port)
            case "udp":
                return .openvpn(.udp, port)
            default:
                return R2Config.defaultProtocol
            }
        case "wireguard":
            return .wireguard(.udp, port)
        default:
            return R2Config.defaultProtocol
        }
    }
    
    static func serversListKey() -> String {
        switch getSavedProtocol() {
        case .ipsec: return "openvpn"
        case .openvpn: return "openvpn"
        case .wireguard: return "wireguard"
        }
    }
    
    func tunnelType() -> TunnelType {
        switch self {
        case .ipsec:
            return TunnelType.ipsec
        case .openvpn:
            return TunnelType.openvpn
        case .wireguard:
            return TunnelType.wireguard
        }
    }
    
    func port() -> Int {
        switch self {
        case .ipsec:
            return 500
        case .openvpn(_, let port):
            return port
        case .wireguard(_, let port):
            return port
        }
    }
    
    func protocolType() -> String {
        switch self {
        case .ipsec:
            return "IKEv2"
        case .openvpn(let proto, _):
            switch proto {
            case .tcp:
                return "TCP"
            case .udp:
                return "UDP"
            }
        case .wireguard:
            return "UDP"
        }
    }
    
    static func == (lhs: ConnectionSettings, rhs: ConnectionSettings) -> Bool {
        switch (lhs, rhs) {
        case (.ipsec, .ipsec):
            return true
        case (.openvpn(let proto, let port), .openvpn(let proto2, let port2)):
            return (proto == proto2 && port == port2)
        case (.wireguard(let proto, let port), .wireguard(let proto2, let port2)):
            return (proto == proto2 && port == port2)
        default:
            return false
        }
    }
    
}


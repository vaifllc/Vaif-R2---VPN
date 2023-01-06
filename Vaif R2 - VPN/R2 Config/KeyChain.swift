//
//  KeyChain.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 1/3/23.
//

import KeychainAccess

class KeyChain {
    
    private static let usernameKey = "username"
    private static let tempUsernameKey = "tempUsernameKey"
    private static let wgPublicKeyKey = "WGPublicKey"
    private static let wgPrivateKeyKey = "WGPrivateKey"
    private static let wgIpAddressKey = "WGIpAddressKey"
    private static let wgIpv6HostKey = "WGIPv6HostKey"
    private static let wgIpAddressesKey = "WGIpAddressesKey"
    private static let sessionTokenKey = "session_token"
    private static let vpnUsernameKey = "vpn_username"
    private static let vpnPasswordKey = "vpn_password"
    
    static let bundle: Keychain = {
        return Keychain(service: "net.ivpn.clients.ios", accessGroup: "WQXXM75BYN.net.ivpn.IVPN-Client").accessibility(.whenPasscodeSetThisDeviceOnly)
    }()
    
    class var username: String? {
        get {
            return KeyChain.bundle[usernameKey]
        }
        set {
            KeyChain.bundle[usernameKey] = newValue
        }
    }
    
    class var tempUsername: String? {
        get {
            return KeyChain.bundle[tempUsernameKey]
        }
        set {
            KeyChain.bundle[tempUsernameKey] = newValue
        }
    }
    
    class var wgPublicKey: String? {
        get {
            return KeyChain.bundle[wgPublicKeyKey]
        }
        set {
            KeyChain.bundle[wgPublicKeyKey] = newValue
        }
    }
    
    class var wgPrivateKey: String? {
        get {
            return KeyChain.bundle[wgPrivateKeyKey]
        }
        set {
            KeyChain.bundle[wgPrivateKeyKey] = newValue
        }
    }
    
    class var wgIpAddress: String? {
        get {
            return KeyChain.bundle[wgIpAddressKey]
        }
        set {
            KeyChain.bundle[wgIpAddressKey] = newValue
        }
    }
    
    class var wgIpAddresses: String? {
        get {
            return KeyChain.bundle[wgIpAddressesKey]
        }
        set {
            KeyChain.bundle[wgIpAddressesKey] = newValue
        }
    }
    
    class var wgIpv6Host: String? {
        get {
            return KeyChain.bundle[wgIpv6HostKey]
        }
        set {
            KeyChain.bundle[wgIpv6HostKey] = newValue
        }
    }
    
    class var sessionToken: String? {
        get {
            return KeyChain.bundle[sessionTokenKey]
        }
        set {
            KeyChain.bundle[sessionTokenKey] = newValue
        }
    }
    
    class var vpnUsername: String? {
        get {
            return KeyChain.bundle[vpnUsernameKey]
        }
        set {
            KeyChain.bundle[vpnUsernameKey] = newValue
        }
    }
    
    class var vpnPassword: String? {
        get {
            return KeyChain.bundle[vpnPasswordKey]
        }
        set {
            KeyChain.bundle[vpnPasswordKey] = newValue
        }
    }
    
    class var vpnPasswordRef: Data? {
        return KeyChain.bundle[attributes: vpnPasswordKey]?.persistentRef
    }
    
    static func save(session: R2Session) {
        sessionToken = session.token
        vpnUsername = session.vpnUsername
        vpnPassword = session.vpnPassword
        
        if let wireguardResult = session.wireguard, let ipAddress = wireguardResult.ipAddress {
            KeyChain.wgIpAddress = ipAddress
        }
    }
    
    static func clearAll() {
        username = nil
        tempUsername = nil
        wgPrivateKey = nil
        wgPublicKey = nil
        wgIpAddress = nil
        wgIpAddresses = nil
        sessionToken = nil
        vpnUsername = nil
        vpnPassword = nil
    }
    
}


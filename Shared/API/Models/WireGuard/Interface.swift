//
//  Interface.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 1/3/23.
//

import Foundation
import Network
import WireGuardKitC

struct Interface {
    
    // MARK: - Properties -
    
    var addresses: String?
    var listenPort: Int
    var privateKey: String?
    var dns: String?
    
    var publicKey: String? {
        if let privateKeyString = privateKey, let privateKey = Data(base64Encoded: privateKeyString) {
            var publicKey = Data(count: 32)
            privateKey.withUnsafeUInt8Bytes { privateKeyBytes in
                publicKey.withUnsafeMutableUInt8Bytes { mutableBytes in
                    curve25519_derive_public_key(mutableBytes, privateKeyBytes)
                }
            }
            return publicKey.base64EncodedString()
        } else {
            return nil
        }
    }
    
    // MARK: - Initialize -
    
    init(addresses: String? = nil, listenPort: Int = 0, privateKey: String? = nil, dns: String? = nil) {
        self.addresses = addresses
        self.listenPort = listenPort
        self.privateKey = privateKey
        self.dns = dns
    }
    
    init?(_ dict: NSDictionary) {
        if let ipAddress = dict.value(forKey: "ip_address") as? String {
            self.addresses = ipAddress
        } else {
            log.error( "Cannot create Interface: no 'ip_address' field specified")
            return nil
        }
        
        listenPort = 0
    }
    
    // MARK: - Methods -
    
    static func generatePrivateKey() -> String {
        var privateKey = Data(count: 32)
        privateKey.withUnsafeMutableUInt8Bytes { mutableBytes in
            curve25519_generate_private_key(mutableBytes)
        }
        
        return privateKey.base64EncodedString()
    }
    
    static func getAddresses(ipv4: String?, ipv6: String?) -> String {
        guard let ipv4 = ipv4 else {
            return ""
        }
        
        guard let ipv6 = ipv6 else {
            return ipv4
        }
        
        let ipv6Address = IPv6Address("\(ipv6.components(separatedBy: "/")[0])\(ipv4)")
        
        return "\(ipv4),\(ipv6Address?.debugDescription ?? "")/64"
    }
    
}

//
//  ExtensionKeyManager.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 1/3/23.
//

import Foundation

struct ExtensionKeyManager {
    
    static let shared = ExtensionKeyManager()
    
    static var regenerationCheckInterval: TimeInterval {
        if R2Config.useDebugWireGuardKeyUpgrade {
            return TimeInterval(10)
        }
        
        return TimeInterval(60 * 60)
    }
    
    static var regenerationInterval: TimeInterval {
        var regenerationRate = UserDefaults.shared.wgRegenerationRate
        
        if regenerationRate <= 0 {
            regenerationRate = 1
        }
        
        if R2Config.useDebugWireGuardKeyUpgrade {
            return TimeInterval(regenerationRate * 60)
        }
        
        return TimeInterval(regenerationRate * 60 * 60 * 24)
    }
    
    func upgradeKey(completion: @escaping (String?, String?) -> Void) {
        guard ExtensionKeyManager.needToRegenerate() else {
            completion(nil, nil)
            return
        }
        
        var interface = Interface()
        interface.privateKey = Interface.generatePrivateKey()
        
        let params = ApiManager.authParams + [
            URLQueryItem(name: "connected_public_key", value: KeyChain.wgPublicKey ?? ""),
            URLQueryItem(name: "public_key", value: interface.publicKey ?? "")
        ]
        
        let request = ApiRequestDI(method: .post, endpoint: R2Config.apiSessionWGKeySet, params: params)
        
        ApiManager.shared.request(request) { (result: R1Result<InterfaceResult>) in
            switch result {
            case .success(let model):
                var ipAddress = model.ipAddress
                KeyChain.wgIpAddress = ipAddress
                
                if UserDefaults.shared.isIPv6 {
                    ipAddress = Interface.getAddresses(ipv4: model.ipAddress, ipv6: KeyChain.wgIpv6Host)
                    KeyChain.wgIpAddresses = ipAddress
                }
                
                UserDefaults.shared.set(Date(), forKey: UserDefaults.Key.wgKeyTimestamp)
                KeyChain.wgPrivateKey = interface.privateKey
                KeyChain.wgPublicKey = interface.publicKey
                completion(interface.privateKey, ipAddress)
            case .failure:
                completion(nil, nil)
            }
        }
    }
    
    static func needToRegenerate() -> Bool {
        guard Date() > UserDefaults.shared.wgKeyTimestamp.addingTimeInterval(ExtensionKeyManager.regenerationInterval) else { return false }
        
        return true
    }
    
}


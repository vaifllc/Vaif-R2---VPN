//
//  Key+Codable.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 9/26/22.
//

import Foundation

extension Key {
    enum CodingKeys: String, CodingKey {
        case keyID = "ID"
        case privateKey
        case flags
        
        case token
        case signature
        
        case activation
        
        case primary
        case active
        case version
    }
}

extension Key: Codable {
    
    public convenience init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let keyID = try container.decode(String.self, forKey: .keyID)
        let privateKey = try container.decodeIfPresent(String.self, forKey: .privateKey)
        
        let flags = try container.decodeIfPresent(Int.self, forKey: .flags)
        
        let token = try container.decodeIfPresent(String.self, forKey: .token)
        let signature = try container.decodeIfPresent(String.self, forKey: .signature)
        
        let activation = try container.decodeIfPresent(String.self, forKey: .activation)
        
        let active = try container.decodeIfPresent(Int.self, forKey: .active)
        let version = try container.decodeIfPresent(Int.self, forKey: .version)
        
        let primary = try container.decodeIfPresent(Int.self, forKey: .primary)
        
        self.init(keyID: keyID, privateKey: privateKey,
                  keyFlags: flags ?? 0,
                  token: token, signature: signature, activation: activation,
                  active: active ?? 0,
                  version: version ?? 0,
                  primary: primary ?? 0)
    }
    
    /// object encode . we don't use it right now. maybe in the future
    /// - Parameter encoder:
    /// - Throws:
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(self.keyID, forKey: .keyID)
        try container.encodeIfPresent(self.privateKey, forKey: .privateKey)
        
        try container.encodeIfPresent(self.keyFlags, forKey: .flags)
        
        try container.encodeIfPresent(self.token, forKey: .token)
        try container.encodeIfPresent(self.signature, forKey: .signature)
        
        try container.encodeIfPresent(self.activation, forKey: .activation)
        
        try container.encodeIfPresent(self.active, forKey: .active)
        try container.encodeIfPresent(self.version, forKey: .version)
        
        try container.encodeIfPresent(self.primary, forKey: .primary)
    }
}


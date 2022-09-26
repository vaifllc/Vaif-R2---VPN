//
//  AddressKey_v2.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 9/26/22.
//

import Foundation

public struct AddressKey_v2: Decodable, Equatable {
    public let id: String
    public let version: Int
    public let privateKey: String
    public let token, signature: String?
    public let primary: Bool, active: Bool
    public let flags: Flags

    public struct Flags: OptionSet, Decodable {
        public let rawValue: UInt8
        
        public init(rawValue: UInt8) {
            self.rawValue = rawValue
        }

        /// 1: Can use key to verify signatures
        public static let verifySignatures          = Flags(rawValue: 1 << 0)
        /// 2: Can use key to encrypt new data
        public static let encryptNewData            = Flags(rawValue: 1 << 1)
        /// 4: Belongs to an external address
        public static let belongsToExternalAddress  = Flags(rawValue: 1 << 2)
    }

    enum CodingKeys: String, CodingKey {
        case id = "ID"
        case version = "Version"
        case privateKey = "PrivateKey"
        case token = "Token"
        case signature = "Signature"
        case primary = "Primary"
        case active = "Active"
        case flags = "Flags"
    }
    
    public init(
        id: String,
        version: Int,
        privateKey: String,
        token: String?,
        signature: String?,
        primary: Bool,
        active: Bool,
        flags: Flags
    ) {
        self.id = id
        self.version = version
        self.privateKey = privateKey
        self.token = token
        self.signature = signature
        self.primary = primary
        self.active = active
        self.flags = flags
    }
    
    // MARK: - Decodable

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        version = try container.decode(Int.self, forKey: .version)
        privateKey = try container.decode(String.self, forKey: .privateKey)
        token = try container.decodeIfPresent(String.self, forKey: .token)
        signature = try container.decodeIfPresent(String.self, forKey: .signature)
        primary = try container.decodeBoolFromInt(forKey: .primary)
        active = try container.decodeBoolFromInt(forKey: .active)
        flags = try container.decode(Flags.self, forKey: .flags)
    }
}

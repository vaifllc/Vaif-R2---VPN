//
//  KeySalt.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 9/22/22.
//

import Foundation

@available(*, deprecated, renamed: "KeySalt")
public typealias AddressKeySalt = KeySalt

public struct KeySalt: Codable, Equatable {
    public let ID: String
    public let keySalt: String?

    public init(ID: String, keySalt: String?) {
        self.ID = ID
        self.keySalt = keySalt
    }
}


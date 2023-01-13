//
//  ServerFeature.swift
//  VaifR2
//
//  Created by VAIF on 1/7/23.
//

import Foundation

public struct ServerFeature: OptionSet {
    
    public let rawValue: Int
    
    public static let secureCore = ServerFeature(rawValue: 1 << 0)
    public static let tor = ServerFeature(rawValue: 1 << 1)
    public static let p2p = ServerFeature(rawValue: 1 << 2)
    public static let xor = ServerFeature(rawValue: 1 << 3)
    public static let ipv6 = ServerFeature(rawValue: 1 << 4)
    
    public static let zero = ServerFeature(rawValue: 0)
    
    public static var description: String {
        return
            "SecureCore = \(secureCore.rawValue)\n" +
            "TOR        = \(tor.rawValue)\n" +
            "P2P        = \(p2p.rawValue)\n" +
            "XOR        = \(xor.rawValue)\n" +
            "IPv6       = \(ipv6.rawValue)\n"
    }
    
    public init(rawValue: Int) {
        self.rawValue = rawValue
    }
}


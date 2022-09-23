//
//  DNS.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 9/22/22.
//

import Foundation

/// dns record
public struct DNS: Equatable {
    
    /// the url
    public let url: String
    
    /// time to lives
    public let ttl: Int
}

/// dns type, right now only support 16 - txt
enum DNSType: Int {
    case txt = 16
}

/// dns result format
enum Type {
    case wireformat
    case json
}


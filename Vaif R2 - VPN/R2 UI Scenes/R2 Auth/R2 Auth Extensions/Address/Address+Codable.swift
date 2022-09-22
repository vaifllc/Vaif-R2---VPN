//
//  Address+Codable.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 9/22/22.
//

import Foundation

extension Address {
    enum CodingKeys: String, CodingKey {
        
        case addressID = "ID"
        case domainID
        
        case email
        
        case send
        case receive
        case status
        case type
        case order
    
        case displayName
        case signature
        case hasKeys
        case keys
    }
}


//
//  NetworkTrust.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 12/27/22.
//

import Foundation

// swiftlint:disable identifier_name
enum NetworkTrust: String, CaseIterable {
    
    case Trusted
    case Untrusted
    case Default
    case None
    
    static var allCasesNormal: [NetworkTrust] {
        return NetworkTrust.allCases.filter { $0 != .None }
    }
    
    static var allCasesDefault: [NetworkTrust] {
        return NetworkTrust.allCases.filter { $0 != .Default }
    }
    
}
// swiftlint:enable identifier_name


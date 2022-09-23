//
//  ClientApp.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 9/22/22.
//

import Foundation

public enum ClientApp: Codable, Equatable {
    case mail
    case vpn
    case drive
    case calendar
    case other(named: String)
    
    public var name: String {
        // this name is used in requests to our BE and should not be changed
        // without checking the affected place and consulting the changes with BE devs
        switch self {
        case .mail: return "mail"
        case .vpn: return "vpn"
        case .drive: return "drive"
        case .calendar: return "calendar"
        case .other(let named): return named
        }
    }
}


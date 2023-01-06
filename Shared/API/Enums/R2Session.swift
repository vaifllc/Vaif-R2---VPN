//
//  R2Session.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 1/3/23.
//

import Foundation

struct WireGuardResult: Codable {
    let status: Int?
    let message: String?
    let ipAddress: String?
}

struct R2Session: Decodable {
    let token: String?
    let vpnUsername: String?
    let vpnPassword: String?
    let serviceStatus: ServiceStatus
    let wireguard: WireGuardResult?
}

//
//  Capability.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 1/3/23.
//

import Foundation

enum Capability: String {
    case multihop = "multihop"
    case portForwarding = "port-forwarding"
    case wireguard = "wireguard"
    case privateEmails = "private-emails"
}

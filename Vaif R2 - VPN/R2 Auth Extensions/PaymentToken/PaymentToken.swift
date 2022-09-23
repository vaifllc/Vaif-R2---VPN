//
//  PaymentToken.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 9/22/22.
//

import Foundation

public struct PaymentToken: Codable, Equatable {

    public enum Status: Int, Codable {
        case pending = 0
        case chargeable
        case failed
        case consumed
        case notSupported
    }

    public let token: String
    public let status: PaymentToken.Status
}

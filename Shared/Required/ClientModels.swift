//
//  ClientModels.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 9/18/22.
//

import Foundation

struct IP: Codable {
    let ip: String
}

struct SpeedTestBucket: Codable {
    let bucket: String
}

struct GetKey: Codable {
    let id: String
    let b64: String
}

struct SubscriptionEvent: Codable {
    let message: String
}

struct Subscription: Codable {
    let planType: PlanType
    let receiptId: String
    let expirationDate: String
    let expirationDateString: String
    let expirationDateMs: Int
    let cancellationDate: String?
    let cancellationDateString: String?
    let cancellationDateMs: Int?
    
    struct PlanType: RawRepresentable, RawValueCodable, Hashable {
        let rawValue: String
        init(rawValue: String) {
            self.rawValue = rawValue
        }
        
        static let monthly = PlanType(rawValue: "ios-monthly")
        static let annual = PlanType(rawValue: "ios-annual")
        static let proMonthly = PlanType(rawValue: "all-monthly")
        static let proAnnual = PlanType(rawValue: "all-annual")
    }
}

struct SignIn: Codable {
    let code: Int
    let message: String
}

struct R2Signup: Codable {
    let code: Int
    let message: String
}

struct R2ApiError: Codable, Error {
    let code: Int
    let message: String
}

// MARK: - Helpers

public enum RawValueCodableError: Error {
    case wrongRawValue
}

public protocol RawValueCodable: RawRepresentable, Codable {
}

public extension RawValueCodable where RawValue: Codable {
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let rawValue = try container.decode(RawValue.self)
        if let value = Self.init(rawValue: rawValue) {
            self = value
        } else {
            throw RawValueCodableError.wrongRawValue
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(rawValue)
    }
}



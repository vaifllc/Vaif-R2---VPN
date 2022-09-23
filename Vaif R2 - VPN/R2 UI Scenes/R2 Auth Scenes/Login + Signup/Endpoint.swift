//
//  Endpoint.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 9/22/22.
//

import Foundation

protocol Endpoint {
    associatedtype Response: Codable
    var request: URLRequest { get }
}

public struct ErrorResponse: Codable {

    public var code: Int
    public var error: String
    public var errorDescription: String

    public init(code: Int, error: String, errorDescription: String) {
        self.code = code
        self.error = error
        self.errorDescription = errorDescription
    }
}

public extension NSError {
    convenience init(_ serverError: ErrorResponse) {
        let userInfo = [NSLocalizedDescriptionKey: serverError.error,
                        NSLocalizedFailureReasonErrorKey: serverError.errorDescription]

        self.init(domain: "ProtonCore-Networking", code: serverError.code, userInfo: userInfo)
    }
}


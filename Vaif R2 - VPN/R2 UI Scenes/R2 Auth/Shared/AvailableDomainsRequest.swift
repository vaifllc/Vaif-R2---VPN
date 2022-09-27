//
//  AvailableDomainsRequest.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 9/26/22.
//

import Foundation



struct AvailableDomainResponse: Codable {
    var domains: [String]
}

public enum AvailableDomainsType: String {
    case login
    case signup
}

class AvailableDomainsRequest: Request {
    let type: AvailableDomainsType

    init(type: AvailableDomainsType) {
        self.type = type
    }

    var path: String {
        return "/domains/available"
    }

    var isAuth: Bool {
        return false
    }

    var parameters: [String: Any]? {
        return ["Type": type.rawValue]
    }
}

//
//  CountryCode.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 9/21/22.
//

import Foundation

public struct CountryCode: Decodable {
    public let country_code: String
    public let country_en: String
    public let phone_code: Int
}

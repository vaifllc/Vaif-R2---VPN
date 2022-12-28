//
//  GeoLookup.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 12/27/22.
//

import Foundation

struct GeoLookup: Decodable {
    
    let ipAddress: String
    let countryCode: String
    let country: String
    let city: String
    let isIvpnServer: Bool
    let isp: String
    let latitude: Double
    let longitude: Double
    
    func isEqualLocation(to comparingModel: GeoLookup) -> Bool {
        return city == comparingModel.city && country == comparingModel.country
    }
    
}


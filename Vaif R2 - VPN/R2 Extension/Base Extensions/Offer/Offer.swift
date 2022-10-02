//
//  Offer.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 9/28/22.
//

import Foundation


public struct Offer: Codable {
    public let label: String
    public let url: String
    public let icon: String
    public let panel: OfferPanel?
    
    // Our decoding strategy changes first letter to lowercase
    enum CodingKeys: String, CodingKey {
        case label
        case url = "URL"
        case icon
        case panel
    }
}

public struct OfferPanel: Codable {
    public let incentive: String
    public let incentivePrice: String
    public let pill: String
    public let pictureURL: String
    public let title: String
    public let features: [OfferFeature]
    public let featuresFooter: String
    public let button: OfferButton
    public let pageFooter: String
}

public struct OfferFeature: Codable {
    public let iconURL: String
    public let text: String
}

public struct OfferButton: Codable {
    public let url: String
    public let text: String

    enum CodingKeys: String, CodingKey {
        case text
        case url = "URL"
    }
}

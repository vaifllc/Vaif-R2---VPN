//
//  CountryModel.swift
//  VaifR2
//
//  Created by VAIF on 1/7/23.
//

import Foundation
import CoreLocation

public class CountryModel: Comparable, Hashable {
    
    public let countryCode: String
    public var lowestTier: Int
    public var feature: ServerFeature = ServerFeature.zero // This is signal keyword feature
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(countryCode)
    }
    
    public var description: String {
        return
            "Country code: \(countryCode)\n" +
            "Lowest tier: \(lowestTier)\n" +
            "Feature: \(feature)\n"
    }
    
    public var country: String {
        return LocalizationUtility.default.countryName(forCode: countryCode) ?? ""
    }
    // FUTURETODO: need change to load from server response. right not the response didnt in used
    public var location: CLLocationCoordinate2D {
        return LocationUtility.coordinate(forCountry: countryCode)
    }
    
     init(serverModel: ServerModel) {
        countryCode = serverModel.countryCode
        lowestTier = serverModel.tier
        feature = self.extractKeyword(serverModel)
    }
    
    /*
     *  Updates lowest tier property of the country - property
     *  coresponds to the tier of server with lowest access needed
     *  for connection.
     */
    public func update(tier: Int) {
        if lowestTier > tier {
            lowestTier = tier
        }
    }
    
    /*
     *  Updates highlight keyword of the country servers according to
     *  predetermined order of importance.
     */
    public func update(feature: ServerFeature) {
        self.feature.insert(feature)
    }
    
    public func matches(searchQuery: String) -> Bool {
        return country.contains(searchQuery)
    }
    
    // MARK: - Private setup functions
    private func extractKeyword(_ server: ServerModel) -> ServerFeature {
//        if server.feature.contains(.tor) {
//            return .tor
//        } else if server.feature.contains(.p2p) {
//            return .p2p
//        }
        return ServerFeature.zero
    }
    
    // MARK: - Static functions
    public static func == (lhs: CountryModel, rhs: CountryModel) -> Bool {
        return lhs.countryCode == rhs.countryCode
    }
    
    public static func < (lhs: CountryModel, rhs: CountryModel) -> Bool {
        return lhs.countryCode < rhs.countryCode
    }
}


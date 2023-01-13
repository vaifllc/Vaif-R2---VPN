//
//  LocationUtility.swift
//  VaifR2
//
//  Created by VAIF on 1/7/23.
//

import Foundation
import CoreLocation

public class LocationUtility {
    
    public static func coordinate(forCountry countryCode: String) -> CLLocationCoordinate2D {
        return MapConstants.countryCoordinates[countryCode.uppercased()] ?? CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0)
    }
}


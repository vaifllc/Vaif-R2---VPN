//
//  CityViewModel.swift
//  VaifR2
//
//  Created by VAIF on 1/7/23.
//

import Foundation
import UIKit


public protocol CityViewModel: ConnectViewModel {
    var cityName: String { get }
    var translatedCityName: String? { get }
    var countryName: String { get }
    var countryFlag: UIImage? { get }

    var connectionChanged: (() -> Void)? { get set }

    func updateTier()
}

extension CityViewModel {
    var displayCityName: String {
        return translatedCityName ?? cityName
    }
}

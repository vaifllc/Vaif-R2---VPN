//
//  ServerViewModel.swift
//  VaifR2
//
//  Created by VAIF on 1/7/23.
//

import Foundation
import UIKit

public protocol ServerViewModel: AnyObject, ConnectViewModel {
    var description: String { get }
    var isSmartAvailable: Bool { get }
    var torAvailable: Bool { get }
    var p2pAvailable: Bool { get }
    var streamingAvailable: Bool { get }
    var connectionChanged: (() -> Void)? { get set }
    var alphaOfMainElements: CGFloat { get }
    var isUsersTierTooLow: Bool { get }
    var underMaintenance: Bool { get }
    var loadValue: String { get }
    var loadColor: UIColor { get }
    var city: String { get }
    var translatedCity: String? { get }
    var entryCountryName: String? { get }
    var entryCountryFlag: UIImage? { get }
    var countryName: String { get }
    var countryFlag: UIImage? { get }

    func updateTier()
}

extension ServerViewModel {
    var displayCityName: String {
        return translatedCity ?? city
    }
}


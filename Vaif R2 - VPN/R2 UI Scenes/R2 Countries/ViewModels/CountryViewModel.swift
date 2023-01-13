//
//  CountryViewModel.swift
//  VaifR2
//
//  Created by VAIF on 1/7/23.
//

import Foundation
import UIKit
import Search

public protocol CountryViewModel: AnyObject, ConnectViewModel {
    var description: String { get }
    var isSmartAvailable: Bool { get }
    var torAvailable: Bool { get }
    var p2pAvailable: Bool { get }
    var connectionChanged: (() -> Void)? { get set }
    var alphaOfMainElements: CGFloat { get }
    var flag: UIImage? { get }
    var isSecureCoreCountry: Bool { get }

    func getServers() -> [ServerTier: [ServerViewModel]]
    func getCities() -> [CityViewModel]
}

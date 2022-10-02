//
//  Image+Flag.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 9/28/22.
//

import Foundation
import UIKit
public extension Image {
    static func flag(countryCode: String) -> Image? {
        return IconProvider.flag(forCountryCode: countryCode)
    }
}

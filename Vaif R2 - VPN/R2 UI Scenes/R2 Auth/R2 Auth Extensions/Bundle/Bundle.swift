//
//  Bundle.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 9/21/22.
//

import Foundation

class Common {
    public static var bundle: Bundle {
        return Bundle(path: Bundle(for: Common.self).path(forResource: "Resources-CoreTranslation", ofType: "bundle")!)!
    }
}

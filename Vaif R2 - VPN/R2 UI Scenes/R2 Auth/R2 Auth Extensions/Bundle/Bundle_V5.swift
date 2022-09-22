//
//  Bundle_V5.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 9/21/22.
//

import Foundation

class Common_V5 {
    public static var bundle: Bundle {
        return Bundle(path: Bundle(for: Common_V5.self).path(forResource: "Resources-CoreTranslation-V5", ofType: "bundle")!)!
    }
}


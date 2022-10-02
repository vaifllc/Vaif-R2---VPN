//
//  HVCommon.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 9/30/22.
//

import Foundation


public final class HVCommon {

    public static func defaultSupportURL(clientApp: ClientApp) -> URL {
        switch clientApp {
        case .vpn:
            return URL(string: "https://protonvpn.com/support/protonvpn-human-verification/")!
        default:
            return URL(string: "https://protonmail.com/support/knowledge-base/human-verification/")!
        }
    }

    public static var bundle: Bundle {
        return Bundle(path: Bundle(for: HVCommon.self).path(forResource: "Resources-HumanVerification", ofType: "bundle")!)!
    }
}

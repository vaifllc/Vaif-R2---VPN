//
//  SettingsV5.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 9/26/22.
//

import UIKit

enum Settings {
    static func actionSheetSectionTitleTransformation(title: String) -> String {
        title
    }
    static var animatedChevronProtonButton = true

    #if canImport(UIKit)
    static let bannerTextColorSuccess: UIColor = ColorProvider.TextInverted
    static let bannerTextColorError: UIColor = ColorProvider.TextInverted
    static let bannerTextColorWarning: UIColor = ColorProvider.TextInverted
    
    static let bannerAssistBgColorInfo = UIColor.dynamic(light: ColorProvider.White.withAlphaComponent(0.2), dark: ColorProvider.Ebb)
    static let bannerAssistassistHighBgColorInfo = UIColor.dynamic(light: ColorProvider.White.withAlphaComponent(0.4), dark: ColorProvider.Cloud)
    #endif
}


//
//  LocalizedString+Fallback.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 9/28/22.
//

import Foundation


func localizeStringAndFallbackToEn(_ key: String, _ table: String) -> String {
    let format = NSLocalizedString(key, tableName: table, bundle: Bundle(for: BundleToken.self), comment: "")
    if format != key || NSLocale.preferredLanguages.first == "en" {
        return format
    }

    // Fall back to en
    guard let path = Bundle.main.path(forResource: "en", ofType: "lproj"), let bundle = Bundle(path: path) else {
        return format
    }
    return NSLocalizedString(key, bundle: bundle, comment: "")
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type

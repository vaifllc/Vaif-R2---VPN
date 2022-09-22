//
//  Brand.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 9/22/22.
//

import Foundation

public enum Brand {
    case proton
    case vpn
    
    public static var currentBrand: Brand = .proton
}

#if canImport(UIKit)

import UIKit

open class DarkModeAwareNavigationViewController: UINavigationController {
    override open var preferredStatusBarStyle: UIStatusBarStyle { darkModeAwarePreferredStatusBarStyle() }
}

public func darkModeAwareValue<T>(value: () -> T, protonFallback: () -> T, vpnFallback: () -> T) -> T {
    if #available(iOS 13, *) {
        return value()
    } else if ColorProvider.brand == .vpn {
        return vpnFallback()
    } else {
        return protonFallback()
    }
}

public func darkModeAwarePreferredStatusBarStyle() -> UIStatusBarStyle {
    darkModeAwareValue { .default } protonFallback: { .default } vpnFallback: { .lightContent }
}

#endif

#if os(macOS)

public func darkModeAwareValue<T>(value: () -> T, protonFallback: () -> T, vpnFallback: () -> T) -> T {
    if #available(OSX 10.14, *) {
        return value()
    } else if ColorProvider.brand == .vpn {
        return vpnFallback()
    } else {
        return protonFallback()
    }
}

#endif


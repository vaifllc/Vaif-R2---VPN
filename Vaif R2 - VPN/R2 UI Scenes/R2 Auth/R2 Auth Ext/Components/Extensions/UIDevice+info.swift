//
//  UIDevice+info.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 9/21/22.
//

import UIKit
public extension UIDevice {
    /// A boolean value that indicates the device has a physical home button or not.
    static var hasPhysicalHome: Bool {
        guard #available(iOS 11.0, *) else {
            // Device that under iOS 11 must have physical home button
            return true
        }

        guard let application = UIApplication.getInstance(),
              let keyWindow = application.windows.first,
              keyWindow.safeAreaInsets.bottom > 0 else {
            // Device has physical home button
            return true
        }
        return false
    }

    /// Return `safeAreaInsets` of the device.
    /// Compatible with iOS lower than `11.0`
    static let safeGuide: UIEdgeInsets = {
        guard #available(iOS 11.0, *) else {
            // Device has physical home button
            return .zero
        }
        guard let application = UIApplication.getInstance(),
              let keyWindow = application.windows.first else {
            // Device has physical home button
            return .zero
        }
        return keyWindow.safeAreaInsets
    }()
}


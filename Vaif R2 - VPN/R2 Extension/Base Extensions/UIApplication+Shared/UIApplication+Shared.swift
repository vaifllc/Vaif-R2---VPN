//
//  UIApplication+Shared.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 9/26/22.
//

import Foundation
import UIKit

public extension UIApplication {
    /// A hacky way to get shared instance
    /// UIApplication.shared can't be used in share extension
    static func getInstance() -> UIApplication? {
        return UIApplication.value(forKeyPath: #keyPath(UIApplication.shared)) as? UIApplication
    }

    static func openURLIfPossible(_ url: URL) {
        let selector = Selector("openURL:")
        if UIApplication.getInstance()?.responds(to: selector) == true {
            UIApplication.getInstance()?.perform(selector, with: url as NSURL)
        }
    }
}

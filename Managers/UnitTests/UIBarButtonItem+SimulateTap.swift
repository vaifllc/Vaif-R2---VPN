//
//  UIBarButtonItem+SimulateTap.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 10/9/22.
//

#if canImport(UIKit)

import UIKit

extension UIBarButtonItem {

    public func simulateTap() {
        if let action = action {
            _ = target?.perform(action, with: self)
        }
    }

}

#endif


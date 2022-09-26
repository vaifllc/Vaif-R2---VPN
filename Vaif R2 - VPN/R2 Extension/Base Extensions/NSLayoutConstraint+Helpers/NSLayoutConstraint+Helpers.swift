//
//  NSLayoutConstraint+Helpers.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 9/26/22.
//

import Foundation
import UIKit

extension UILayoutPriority {
    var lower: UILayoutPriority {
        UILayoutPriority(rawValue: rawValue - 1)
    }
}

extension NSLayoutConstraint {

    func prioritised(as priority: UILayoutPriority) -> NSLayoutConstraint {
        self.priority = priority
        return self
    }

}

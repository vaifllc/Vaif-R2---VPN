//
//  UIView+Amination.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 9/26/22.
//

import Foundation
import UIKit

extension UIView {
    func fadeIn(withDuration duration: TimeInterval = 1.0, completion: (() -> Void)? = nil) {
        fade(withDuration: duration, alpha: 1.0, completion: completion)
    }

    func fadeOut(withDuration duration: TimeInterval = 1.0, completion: (() -> Void)? = nil) {
        fade(withDuration: duration, alpha: 0.0, completion: completion)
    }

    private func fade(withDuration duration: TimeInterval, alpha: CGFloat, completion: (() -> Void)? = nil) {
        UIView.animate(withDuration: duration, animations: {
            self.alpha = alpha
        }, completion: { _ in
            completion?()
        })
    }
}

//
//  UIView+Constraints.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 9/21/22.
//

import UIKit

public extension UIView {
    func fillSuperview() {
        guard let superview = superview else { return }
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: superview.topAnchor),
            bottomAnchor.constraint(equalTo: superview.bottomAnchor),
            leftAnchor.constraint(equalTo: superview.leftAnchor),
            rightAnchor.constraint(equalTo: superview.rightAnchor)
        ])
    }

    func centerXInSuperview(constant: CGFloat = 0) {
        guard let anchor = superview?.centerXAnchor else { return }
        translatesAutoresizingMaskIntoConstraints = false
        centerXAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
    }

    func centerYInSuperview(constant: CGFloat = 0) {
        guard let anchor = superview?.centerYAnchor else { return }
        translatesAutoresizingMaskIntoConstraints = false
        centerYAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
    }

    func centerInSuperview() {
        centerXInSuperview()
        centerYInSuperview()
    }

    func setSizeContraint(height: CGFloat?, width: CGFloat?) {
        self.translatesAutoresizingMaskIntoConstraints = false
        if let _height = height {
            self.heightAnchor.constraint(equalToConstant: _height).isActive = true
        }
        if let _width = width {
            self.widthAnchor.constraint(equalToConstant: _width).isActive = true
        }
    }
}


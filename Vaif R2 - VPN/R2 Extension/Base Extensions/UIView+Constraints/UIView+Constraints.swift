//
//  UIView+Constraints.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 9/26/22.
//

import Foundation
import UIKit

public extension UIView {
    
    func addFillingSubview(_ subView: UIView) {
        self.addSubview(subView)
        
        subView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        subView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        subView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        subView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
    }
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

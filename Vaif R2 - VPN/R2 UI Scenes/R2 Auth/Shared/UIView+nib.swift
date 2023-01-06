//
//  UIView+nib.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 10/3/22.
//

import UIKit

extension UIView {
    
    func bindFrameToSuperviewBounds(top: CGFloat = 0, bottom: CGFloat = 0, leading: CGFloat = 0, trailing: CGFloat = 0) {
        guard let superview = self.superview else { return }
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.topAnchor.constraint(equalTo: superview.topAnchor, constant: top).isActive = true
        self.bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: bottom).isActive = true
        self.leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: leading).isActive = true
        self.trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: trailing).isActive = true
    }
    
    /**
    Rotate a view by specified degrees

    - parameter angle: angle in degrees
    */
    
    func rotate(angle: CGFloat) {
        let radians = angle / 180.0 * CGFloat.pi
        let rotation = self.transform.rotated(by: radians)
        self.transform = rotation
    }
    
    /// Load a view from nib/xib file that is named the same as the class itself
    static func loadViewFromNib<T>() -> T {
        let nibObjects = nib.instantiate(withOwner: self, options: nil)
        
        for object in nibObjects {
            if let result = object as? T {
                return result
            }
        }
        fatalError("No suitable object found in nib file")
    }
    
    static var identifier: String {
        return String(describing: self)
    }
    
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
}


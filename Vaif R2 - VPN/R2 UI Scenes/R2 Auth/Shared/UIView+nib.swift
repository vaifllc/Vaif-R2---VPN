//
//  UIView+nib.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 10/3/22.
//

import UIKit

extension UIView {
    
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


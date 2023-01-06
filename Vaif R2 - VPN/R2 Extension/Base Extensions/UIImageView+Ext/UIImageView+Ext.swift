//
//  UIImageView+Ext.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 1/2/23.
//

import UIKit

extension UIImageView {
    
    func setFlagIconBorder() {
        layer.cornerRadius = 2.0
        layer.shadowRadius = 0.5
        if #available(iOS 13.0, *) {
            layer.shadowColor = UIColor.label.cgColor
        } else {
            layer.shadowColor = UIColor.black.cgColor
        }
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowOpacity = 0.3
        backgroundColor = UIColor.clear
    }
    
    func removeFlagIconBorder() {
        layer.shadowOpacity = 0
        layer.shadowColor = UIColor.clear.cgColor
    }
    
}


//
//  UIButton+helper.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 9/26/22.
//

import UIKit

extension UIButton {
    func setBackgroundColor(_ color: UIColor, forState controlState: UIControl.State) {
        var resolvedColor = color
        if #available(iOS 13.0, *) {
            resolvedColor = color.resolvedColor(with: self.traitCollection)
        }
        let colorImage = UIGraphicsImageRenderer(size: CGSize(width: 1, height: 1)).image { _ in
            resolvedColor.setFill()
            UIBezierPath(rect: CGRect(x: 0, y: 0, width: 1, height: 1)).fill()
        }
        setBackgroundImage(colorImage, for: controlState)
    }
}


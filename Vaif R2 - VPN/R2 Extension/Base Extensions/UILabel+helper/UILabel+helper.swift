//
//  UILabel+helper.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 9/26/22.
//

import Foundation
import UIKit

public extension UILabel {
    convenience init(_ _text: String?,
                     font _font: UIFont?,
                     textColor _color: UIColor?,
                     alignment: NSTextAlignment = .left,
                     useAutoLayout: Bool = false) {
        self.init(frame: .zero)
        text = _text
        textAlignment = alignment
        translatesAutoresizingMaskIntoConstraints = !useAutoLayout

        if let _font = _font {
            font = _font
        }

        if let _color = _color {
            textColor = _color
        }
    }
}


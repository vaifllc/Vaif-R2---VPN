//
//  String+Attributed.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 9/22/22.
//

import UIKit

public extension String {
    func getAttributedString(replacement: String, attrFont: UIFont, attrColor: UIColor = ColorProvider.TextNorm) -> NSMutableAttributedString {
        let attrStr = NSMutableAttributedString(string: self)
        if let range = range(of: replacement) {
            let boldedRange = NSRange(range, in: self)
            attrStr.addAttributes([.font: attrFont, .foregroundColor: attrColor], range: boldedRange)
        }
        return attrStr
    }
}

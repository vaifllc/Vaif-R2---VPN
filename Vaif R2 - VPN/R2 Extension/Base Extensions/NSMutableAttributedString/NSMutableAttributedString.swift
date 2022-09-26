//
//  NSMutableAttributedString.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 9/26/22.
//

import Foundation

public extension NSMutableAttributedString {
    func setAttributes(textToFind: String, attributes: [NSAttributedString.Key: Any]) -> Bool {
        let foundRange = self.mutableString.range(of: textToFind)
        if foundRange.location != NSNotFound {
            self.setAttributes(attributes, range: foundRange)
            return true
        }
        return false
    }
}

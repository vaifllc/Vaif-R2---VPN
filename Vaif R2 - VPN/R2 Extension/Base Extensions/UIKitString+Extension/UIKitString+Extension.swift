//
//  UIKitString+Extension.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 10/3/22.
//

import UIKit

extension String {
    
    public func attributed(withColor color: UIColor,
                    fontSize: CGFloat,
                    bold: Bool = false,
                    alignment: NSTextAlignment = .natural,
                    lineSpacing: CGFloat? = nil,
                    lineBreakMode: NSLineBreakMode? = nil) -> NSAttributedString {
        let font = bold ? UIFont.boldSystemFont(ofSize: fontSize) : UIFont.systemFont(ofSize: fontSize)
        return attributed(withColor: color, font: font, alignment: alignment, lineSpacing: lineSpacing, lineBreakMode: lineBreakMode)
    }
    
    func attributed(withColor color: UIColor,
                    font: UIFont,
                    alignment: NSTextAlignment = .natural,
                    lineSpacing: CGFloat? = nil,
                    lineBreakMode: NSLineBreakMode? = nil) -> NSAttributedString {
        
        let newString = NSMutableAttributedString(string: self)
        newString.addTextAttributes(withColor: color, font: font, alignment: alignment, lineSpacing: lineSpacing, lineBreakMode: lineBreakMode)
        return newString
    }
    
    func attributedCurrency(withNumberColor numberColor: UIColor,
                            numberFont: UIFont,
                            withTextColor textColor: UIColor,
                            textFont: UIFont
                            ) -> NSAttributedString {
        
        let newString = NSMutableAttributedString(string: self)
        
        let range = (self as NSString).range(of: self)
        newString.addAttribute(NSAttributedString.Key.foregroundColor, value: textColor, range: range)
        newString.addAttribute(NSAttributedString.Key.font, value: textFont, range: range)
        newString.addAttribute(NSAttributedString.Key.backgroundColor, value: UIColor.clear, range: range)
        
        let regex = try? NSRegularExpression(pattern: #"[\d\,\.\ ]+"#, options: NSRegularExpression.Options.init())
        if let matches = regex?.matches(in: self, options: NSRegularExpression.MatchingOptions.init(), range: range) {
            for match in matches {
                let nsRange = match.range
                newString.addAttribute(NSAttributedString.Key.foregroundColor, value: numberColor, range: nsRange)
                newString.addAttribute(NSAttributedString.Key.font, value: numberFont, range: nsRange)
            }
        }
        
        return newString
    }
    
}


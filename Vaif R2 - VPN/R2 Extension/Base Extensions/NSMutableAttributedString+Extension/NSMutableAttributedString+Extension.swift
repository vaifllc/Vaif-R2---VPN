//
//  NSMutableAttributedString+Extension.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 9/27/22.
//

import Foundation
import UIKit
#if canImport(UIKit)
import UIKit
#elseif canImport(Cocoa)
import Cocoa
#endif

// MARK: - Text

extension NSMutableAttributedString {
    
    func addTextAttributes(withColor color: UIColor,
                       font: UIFont,
                       alignment: NSTextAlignment = .left,
                       lineSpacing: CGFloat? = nil,
                       lineBreakMode: NSLineBreakMode? = nil) {
        
        let range = (self.string as NSString).range(of: self.string)
        
        self.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
        self.addAttribute(NSAttributedString.Key.font, value: font, range: range)
        self.addAttribute(NSAttributedString.Key.backgroundColor, value: UIColor.clear, range: range)
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = alignment
        if let lineBreakMode = lineBreakMode {
            paragraphStyle.lineBreakMode = lineBreakMode
        }
        if let lineSpacing = lineSpacing {
            paragraphStyle.lineSpacing = lineSpacing
        }
        self.addAttribute(.paragraphStyle, value: paragraphStyle, range: range)
    }
    
    /// Add a `.link` attribute to a given text
    /// - Parameters:
    ///     - links: Parameters to pass to `add(link: String, withUrl url: String)` method
    public func add(links: [(String, String)]) -> NSMutableAttributedString {
        for (link, url) in links {
            _ = self.add(link: link, withUrl: url)
        }
        return self
    }

    /// Add a `.link` attribute to a given text
    /// - Parameters:
    ///     - link: Text that will become a link
    ///     - withUrl: String representation or URL for a link
    public func add(link: String, withUrl: String) -> NSMutableAttributedString {
        let fullText = self.string
        guard let url = URL(string: withUrl), let subrange = fullText.range(of: link) else {
            return self
        }
        let nsRange = NSRange(subrange, in: fullText)
        self.addAttribute(.link, value: url, range: nsRange)

        return self
    }
    
}

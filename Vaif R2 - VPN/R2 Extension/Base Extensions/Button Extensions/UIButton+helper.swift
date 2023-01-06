//
//  UIButton+helper.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 9/26/22.
//

import UIKit

extension UIButton {
    func setupIcon(imageName: String) {
        setImage(UIImage.init(named: imageName), for: .normal)
        backgroundColor = ColorProvider.FloatyBackground
        layer.cornerRadius = 21
        clipsToBounds = true
    }
    
    func set(title: String, subtitle: String) {
        // Applying the line break mode
        self.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        var buttonText: NSString = "\(title)\n\(subtitle)" as NSString
        
        if subtitle.isEmpty {
            buttonText = "\(title)" as NSString
        }

        // Getting the range to separate the button title strings
        let newlineRange: NSRange = buttonText.range(of: "\n")

        // Getting both substrings
        var substring1 = title
        var substring2 = ""

        if newlineRange.location != NSNotFound {
            substring1 = buttonText.substring(to: newlineRange.location)
            substring2 = buttonText.substring(from: newlineRange.location)
        }
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center

        // Assigning diffrent fonts to both substrings
        let font1: UIFont = UIFont.systemFont(ofSize: 16)
        let attributes1 = [NSMutableAttributedString.Key.font: font1, NSMutableAttributedString.Key.paragraphStyle: paragraphStyle]
        let attrString1 = NSMutableAttributedString(string: substring1, attributes: attributes1)

        let font2: UIFont = UIFont.systemFont(ofSize: 12)
        let attributes2 = [NSMutableAttributedString.Key.font: font2, NSMutableAttributedString.Key.paragraphStyle: paragraphStyle]
        let attrString2 = NSMutableAttributedString(string: substring2, attributes: attributes2)

        // Appending both attributed strings
        attrString1.append(attrString2)

        // Assigning the resultant attributed strings to the button
        self.setAttributedTitle(attrString1, for: [])
    }
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


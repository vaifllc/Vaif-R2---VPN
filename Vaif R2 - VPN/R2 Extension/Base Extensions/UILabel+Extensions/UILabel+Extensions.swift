//
//  UILabel+Extensions.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 9/26/22.
//


import Foundation
import UIKit

extension UILabel {
    
    func icon(text textString: String, imageName: String, alignment: Alignment = .right) {
        guard !imageName.isEmpty else {
            self.text = textString
            return
        }
        
        let image = UIImage(named: imageName)
        guard image != nil else {
            self.text = textString
            return
        }
        
        let attachment = NSTextAttachment()
        attachment.image = image
        let imageSize = attachment.image!.size
        attachment.bounds = CGRect(x: CGFloat(0), y: (font.capHeight - imageSize.height) / 2, width: imageSize.width, height: imageSize.height)
        let imageString = NSAttributedString(attachment: attachment)
        var text = NSAttributedString(string: textString + "  ")
        
        if alignment == .left {
            text = NSAttributedString(string: "  " + textString)
        }
        
        var attributedText = NSMutableAttributedString(attributedString: text)
        attributedText.append(imageString)
        
        if alignment == .left {
            attributedText = NSMutableAttributedString(attributedString: imageString)
            attributedText.append(text)
        }
        
        self.attributedText = attributedText
    }
    
    func iconMirror(text: String, image: UIImage?, alignment: Alignment = .right) {
        if image == nil {
            self.text = text
            return
        }
        
        let leftAttachment = NSTextAttachment()
        if alignment == .left {
            leftAttachment.image = image
            if let leftImage = leftAttachment.image {
                let imageSize = leftImage.size
                leftAttachment.bounds = CGRect(x: CGFloat(0), y: (font.capHeight - imageSize.height) / 2, width: imageSize.width, height: imageSize.height)
            }
        } else {
            leftAttachment.image = image?.with(alpha: 0)
        }
        let leftAttributedString = NSAttributedString(attachment: leftAttachment)
        let leftIcon = NSMutableAttributedString(attributedString: leftAttributedString)
        
        let rightAttachment = NSTextAttachment()
        if alignment == .right {
            rightAttachment.image = image
            if let rightImage = rightAttachment.image {
                let imageSize = rightImage.size
                rightAttachment.bounds = CGRect(x: CGFloat(0), y: (font.capHeight - imageSize.height) / 2, width: imageSize.width, height: imageSize.height)
            }
        } else {
            rightAttachment.image = image?.with(alpha: 0)
        }
        let rightAttributedString = NSAttributedString(attachment: rightAttachment)
        let rightIcon = NSMutableAttributedString(attributedString: rightAttributedString)
        
        let labelText = NSMutableAttributedString(string: "  \(text)  ")
        labelText.append(rightIcon)
        leftIcon.append(labelText)
        self.attributedText = leftIcon
    }
    
    func setLineHeight(lineHeight: CGFloat) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 1.0
        paragraphStyle.lineHeightMultiple = lineHeight
        paragraphStyle.alignment = self.textAlignment

        let attrString = NSMutableAttributedString()
        if let attributedText = self.attributedText {
            attrString.append( attributedText)
        } else {
            attrString.append( NSMutableAttributedString(string: self.text!))
            attrString.addAttribute(NSAttributedString.Key.font, value: self.font!, range: NSMakeRange(0, attrString.length))
        }
        attrString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attrString.length))
        self.attributedText = attrString
    }
}

extension UILabel {
    
    enum Alignment {
        case left
        case right
    }
    
}

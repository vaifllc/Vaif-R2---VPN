//
//  UILabel+link.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 9/21/22.
//

import UIKit

public extension UILabel {
    func textWithLink(text: String, link: String, handler: (() -> Void)?) {
        let termsText = NSMutableAttributedString(string: text)
        let foregroundColor: UIColor = ColorProvider.InteractionNorm
        actionHandler(handler: handler)
        
        if termsText.setAttributes(textToFind: link, attributes: [
            NSAttributedString.Key.foregroundColor: foregroundColor,
            NSAttributedString.Key.underlineColor: UIColor.clear
        ]) {
            attributedText = termsText
            let recognizer = UITapGestureRecognizer(target: self, action: #selector(triggerActionHandler))
            addGestureRecognizer(recognizer)
            isUserInteractionEnabled = true
        }
    }
    
    private func actionHandler(handler:(() -> Void)? = nil) {
        struct ActionHandler {
            static var handler: (() -> Void)?
        }
        if handler != nil {
            ActionHandler.handler = handler
        } else {
            ActionHandler.handler?()
        }
    }

    @objc private func triggerActionHandler() {
        self.actionHandler()
    }
}


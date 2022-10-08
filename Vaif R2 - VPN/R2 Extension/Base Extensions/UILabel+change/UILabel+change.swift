//
//  UILabel+change.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 10/5/22.
//

import Foundation
import UIKit

extension UILabel {
    func changeText(text: String?) {
        if self.text == nil || self.text == "" {
            self.text = text
            return
        }
        
        if self.text != text {
            UIView.animate(withDuration: 0.3, animations: {
                self.transform = CGAffineTransform(translationX: 0, y: -5)
                self.alpha = 0
            }, completion: { bool in
                self.text = text
                self.transform = CGAffineTransform(translationX: 0, y: 10)
                UIView.animate(withDuration: 0.3, animations: {
                    self.transform = CGAffineTransform(translationX: 0, y: 0)
                    self.alpha = 1
                })
            })
        }
    }
}

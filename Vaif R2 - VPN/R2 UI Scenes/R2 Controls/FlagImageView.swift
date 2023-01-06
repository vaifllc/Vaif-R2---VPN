//
//  FlagImageView.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 1/2/23.
//

import UIKit

class FlagImageView: UIImageView {
    
    override var image: UIImage? {
        didSet {
            super.image = image
            updateUpFlagIcon()
        }
    }
    
    override func awakeFromNib() {
        updateUpFlagIcon()
    }
    
    func updateUpFlagIcon() {
        if let accessibilityIdentifier = image?.accessibilityIdentifier {
            if accessibilityIdentifier == "icon-fastest-server" || accessibilityIdentifier == "icon-shuffle" {
                removeFlagIconBorder()
                return
            }
        }
        
        setFlagIconBorder()
    }
    
}


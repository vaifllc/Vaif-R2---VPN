//
//  ColorPickerItem.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 12/28/22.
//

import UIKit

final class ColorPickerItem: UICollectionViewCell {

    @IBOutlet private weak var colorCircleView: UIView!
    
    var color: UIColor = .backgroundColor() {
        didSet {
            colorCircleView.backgroundColor = color
            backgroundColor = .clear
        }
    }

    override var isSelected: Bool {
        didSet {
            if self.isSelected {
                backgroundColor = .normalTextColor()
            } else {
                backgroundColor = .clear
            }
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = layer.frame.size.height / 2
        colorCircleView.layer.cornerRadius = colorCircleView.layer.frame.size.height / 2
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        autoresizingMask = [.flexibleHeight, .flexibleWidth]
        translatesAutoresizingMaskIntoConstraints = true

        colorCircleView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        colorCircleView.translatesAutoresizingMaskIntoConstraints = true
        
        backgroundColor = isSelected ? .normalTextColor() : .clear
    }
}


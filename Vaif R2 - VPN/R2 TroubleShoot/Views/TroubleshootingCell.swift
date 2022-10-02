//
//  TroubleshootingCell.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 9/27/22.
//

import Foundation
import UIKit

class TroubleshootingCell: UITableViewCell {
    
    // Views
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundColor = .backgroundColor()
        titleLabel.textColor = .normalTextColor()
        titleLabel.font = UIFont.boldSystemFont(ofSize: 17)
        
        descriptionLabel.isScrollEnabled = false // Enables auto-height
        descriptionLabel.isUserInteractionEnabled = true
        descriptionLabel.isEditable = false
        descriptionLabel.isSelectable = true
        
        descriptionLabel.textContainer.lineFragmentPadding = 0
        descriptionLabel.backgroundColor = backgroundColor
        descriptionLabel.tintColor = .brandColor()
        descriptionLabel.linkTextAttributes = [
            .foregroundColor: UIColor.brandColor(),
            .underlineStyle: NSUnderlineStyle.single.rawValue,
        ]
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        selectionStyle = .none
    }
    
    // MARK: - Public setters
    
    var title: String? {
        get {
            return titleLabel.text
        }
        set {
            titleLabel.text = newValue
        }
    }
    
    var descriptionAttributed: NSAttributedString {
        get {
            return descriptionLabel.attributedText
        }
        set {
            let string = NSMutableAttributedString(attributedString: newValue)
            string.addTextAttributes(withColor: .weakTextColor(), font: UIFont.systemFont(ofSize: 17), alignment: .left)
            descriptionLabel.attributedText = string
            descriptionLabel.sizeToFit()
        }
    }
    
}

//
//  TooltipTableViewCell.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 12/28/22.
//

import UIKit

class TooltipTableViewCell: UITableViewCell {

    @IBOutlet weak var tooltipLabel: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundColor = ColorProvider.FloatyBackground
        tooltipLabel.textColor = UIColor.weakTextColor()
        tooltipLabel.linkTextAttributes = [
            .foregroundColor: UIColor.textAccent(),
            .underlineStyle: NSUnderlineStyle.single.rawValue,
        ]
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        selectionStyle = .none
    }
    
    static func attributedText(for text: String) -> NSAttributedString {
        return text.attributed(withColor: UIColor.weakTextColor(), fontSize: 13)
    }
    
}


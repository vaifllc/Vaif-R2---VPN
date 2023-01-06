//
//  CheckmarkTableViewCell.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 12/28/22.
//

import UIKit

class CheckmarkTableViewCell: UITableViewCell {

    @IBOutlet weak var label: UILabel!
    
    var completionHandler: (() -> Bool)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundColor = .secondaryBackgroundColor()
        tintColor = .normalTextColor()
        
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = .normalTextColor()
        
        accessoryType = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        selectionStyle = .none
    }
    
    func select() {
        if completionHandler?() ?? true {
            accessoryType = .checkmark
        }
    }
    
    func deselect() {
        accessoryType = .none
    }
    
}


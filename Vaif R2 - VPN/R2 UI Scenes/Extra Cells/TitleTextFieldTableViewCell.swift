//
//  TitleTextFieldTableViewCell.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 12/28/22.
//

import UIKit

class TitleTextFieldTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundColor = .secondaryBackgroundColor()
        titleLabel.font = UIFont.systemFont(ofSize: 17)
        titleLabel.textColor = .normalTextColor()
        
        textField.font = UIFont.systemFont(ofSize: 17)
        textField.textColor = .normalTextColor()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        selectionStyle = .none
    }
    
}


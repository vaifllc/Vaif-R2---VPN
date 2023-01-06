//
//  ButtonTableViewCell.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 12/28/22.
//

import UIKit

class ButtonTableViewCell: UITableViewCell {
    
    @IBOutlet weak var button: UIButton!
    var completionHandler: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundColor = .secondaryBackgroundColor()
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        selectionStyle = .none
    }
    
    @IBAction func buttonTapped(_ sender: Any) {
        if let handler = completionHandler {
            handler()
        }
    }
}


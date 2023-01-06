//
//  InstructionStepTableViewCell.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 12/28/22.
//

import UIKit

class InstructionStepTableViewCell: UITableViewCell {

    @IBOutlet weak var stepView: InstructionStepView!
    @IBOutlet weak var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundColor = .secondaryBackgroundColor()
        label.textColor = .normalTextColor()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        selectionStyle = .none
    }
    
}


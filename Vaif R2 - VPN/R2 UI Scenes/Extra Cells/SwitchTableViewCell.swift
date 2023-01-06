//
//  SwitchTableViewCell.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 12/28/22.
//

import UIKit

final class SwitchTableViewCell: UITableViewCell {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var switchControl: ConfirmationToggleSwitch!
    
    var toggled: ((Bool, @escaping (Bool) -> Void) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.isSelected = false
        
        backgroundColor = .secondaryBackgroundColor()
        label.textColor = .normalTextColor()
        selectionStyle = .none

        let update = { (on: Bool) -> Void in
            self.switchControl.setOn(on, animated: true)
        }

        switchControl.tapped = { [unowned self] in
            self.toggled?(!self.switchControl.isOn, update)
        }
    }
    
}


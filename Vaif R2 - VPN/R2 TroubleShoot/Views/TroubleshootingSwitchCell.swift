//
//  TroubleshootingSwitchCell.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 9/27/22.
//

import Foundation
import UIKit

class TroubleshootingSwitchCell: TroubleshootingCell {
    
    // Views
    @IBOutlet private weak var toggleSwitch: UISwitch!

    var isOn: Bool {
        get {
            return toggleSwitch.isOn
        }
        set {
            toggleSwitch.isOn = newValue
        }
    }

    var isOnChanged: ((Bool) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()

        toggleSwitch.addTarget(self, action: #selector(switchChanged), for: UIControl.Event.valueChanged)
    }

    @objc private func switchChanged() {
        isOnChanged?(toggleSwitch.isOn)
    }
}

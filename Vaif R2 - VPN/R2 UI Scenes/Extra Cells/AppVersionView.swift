//
//  AppVersionView.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 12/28/22.
//

import UIKit

class AppVersionView: UIView {
    @IBOutlet weak var appVersionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundColor = .secondaryBackgroundColor()
        appVersionLabel.textColor = .weakTextColor()
        
    }

}

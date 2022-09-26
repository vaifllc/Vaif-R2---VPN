//
//  CountryCodeTableHeaderView.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 9/26/22.
//

import Foundation
import UIKit

class CountryCodeTableHeaderView: UITableViewHeaderFooterView {

    @IBOutlet weak var titleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.backgroundColor = ColorProvider.SeparatorNorm
        titleLabel.textColor = ColorProvider.TextWeak
    }
}

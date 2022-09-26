//
//  CountryCodeTableViewCell.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 9/26/22.
//

import Foundation
import UIKit

class CountryCodeTableViewCell: UITableViewCell, AccessibleCell {

    @IBOutlet weak var flagImageView: UIImageView!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var codeLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        imageView?.contentMode = .scaleAspectFit
        flagImageView.layer.cornerRadius = 4
        flagImageView.layer.masksToBounds = true
        countryLabel.textColor = ColorProvider.TextNorm
        codeLabel.textColor = ColorProvider.TextWeak
    }

    func configCell(_ countryCode: CountryCode) {
        flagImageView.image = IconProvider.flag(forCountryCode: countryCode.country_code)
        countryLabel.text = countryCode.country_en
        codeLabel.text = "+ \(countryCode.phone_code)"
        generateCellAccessibilityIdentifiers(countryCode.country_en)
        backgroundColor = ColorProvider.BackgroundNorm
    }
}

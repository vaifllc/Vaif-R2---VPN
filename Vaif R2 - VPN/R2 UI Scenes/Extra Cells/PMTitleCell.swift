//
//  PMTitleCell.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 9/28/22.
//

import Foundation
import UIKit


final class PMTitleCell: UITableViewCell {

    static let reuseIdentifier = "PMTitleCell"
    static let nib = UINib(nibName: "PMTitleCell", bundle: LoginAndSignup.bundle)

    // MARK: - Outlets

    @IBOutlet private weak var descriptionLabel: UILabel!

    // MARK: - Properties

    var title: String? {
        didSet {
            descriptionLabel.text = title
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()

        descriptionLabel.textColor = ColorProvider.TextWeak

        selectionStyle = .none
        separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)
    }
}

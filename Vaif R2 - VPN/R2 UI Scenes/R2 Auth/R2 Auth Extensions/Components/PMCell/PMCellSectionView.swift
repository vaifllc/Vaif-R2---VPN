//
//  PMCellSectionView.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 9/21/22.
//

import UIKit

public final class PMCellSectionView: UITableViewHeaderFooterView, AccessibleView {

    public static let reuseIdentifier = "PMCellSectionView"
    public static let nib = UINib(nibName: "PMCellSectionView", bundle: PMUIFoundations.bundle)

    // MARK: - Outlets

    @IBOutlet private weak var titleLabel: UILabel!

    // MARK: - Properties

    public var title: String? {
        didSet {
            titleLabel.text = title
        }
    }

    override public func awakeFromNib() {
        super.awakeFromNib()

        titleLabel.textColor = ColorProvider.TextWeak
        contentView.backgroundColor = UIColor.dynamic(light: .white, dark: .black)
        generateAccessibilityIdentifiers()
    }
}


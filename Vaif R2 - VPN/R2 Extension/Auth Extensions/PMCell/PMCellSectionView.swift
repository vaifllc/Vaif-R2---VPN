//
//  PMCellSectionView.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 9/26/22.
//

import Foundation

import SwiftOnoneSupport
import UIKit
import _Concurrency
import _StringProcessing

public final class PMCellSectionView: UITableViewHeaderFooterView, AccessibleView {

    public static let reuseIdentifier = "PMCellSectionView"
    //public static let nib = UINib(nibName: "PMCellSectionView", bundle: PMUIFoundations.bundle)

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

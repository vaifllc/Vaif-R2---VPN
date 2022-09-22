//
//  PMActionSheetPlainCell.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 9/21/22.
//

import UIKit


final class PMActionSheetPlainCell: UITableViewCell, AccessibleView {

    private var separator: UIView?
    @IBOutlet private var leftIcon: UIImageView!
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var leftIconLeftConstraint: NSLayoutConstraint!
    @IBOutlet private var titleLeftToIcon: NSLayoutConstraint!
    @IBOutlet private var titleLeftToSuperView: NSLayoutConstraint!
    @IBOutlet private var titleRightToIcon: NSLayoutConstraint!
    @IBOutlet private var titleRightToSuperView: NSLayoutConstraint!
    @IBOutlet weak var rightIcon: UIImageView!

    class func nib() -> UINib {
        return UINib(nibName: "PMActionSheetPlainCell", bundle: PMUIFoundations.bundle)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        self.separator = self.addSeparator(leftRef: self.leftIcon, constant: -16)
    }

    func config(item: PMActionSheetPlainItem, indexPath: IndexPath) {
        self.backgroundColor = ColorProvider.BackgroundNorm
        let hasLeftIcon: Bool
        if let leftIcon = item.icon {
            self.leftIcon.image = leftIcon
            self.leftIcon.tintColor = item.iconColor
            hasLeftIcon = true
        } else {
            self.leftIcon.image = nil
            hasLeftIcon = false
        }

        let hasRightIcon: Bool
        if let rightIcon = item.markType.icon {
            self.rightIcon.image = rightIcon
            self.rightIcon.tintColor = ColorProvider.BrandNorm
            hasRightIcon = true
        } else {
            self.rightIcon.image = nil
            hasRightIcon = false
        }

        self.titleLabel.text = item.title
        self.titleLabel.textColor = item.textColor
        self.titleLabel.textAlignment = item.alignment
        self.separator?.isHidden = !item.hasSeparator
        self.accessibilityIdentifier = "itemIndex_\(indexPath.section).\(indexPath.row)"
        self.accessibilityLabel = item.title
        self.setupTitleConstraints(level: item.indentationLevel,
                                   width: item.indentationWidth,
                                   alignment: item.alignment,
                                   hasLeftIcon: hasLeftIcon,
                                   hasRightIcon: hasRightIcon)
        generateAccessibilityIdentifiers()
    }

    private func setupTitleConstraints(
        level: Int, width: CGFloat, alignment: NSTextAlignment, hasLeftIcon: Bool, hasRightIcon: Bool
    ) {

        self.titleLeftToIcon.isActive = hasLeftIcon
        self.titleLeftToSuperView.isActive = !hasLeftIcon
        self.titleRightToIcon.isActive = hasRightIcon
        self.titleRightToSuperView.isActive = !hasRightIcon

        let indentationOffset = CGFloat(level) * width
        if hasLeftIcon {
            self.leftIconLeftConstraint.constant = 16 + indentationOffset
        } else {
            self.titleLeftToSuperView.constant = 16 + indentationOffset
        }
    }
}


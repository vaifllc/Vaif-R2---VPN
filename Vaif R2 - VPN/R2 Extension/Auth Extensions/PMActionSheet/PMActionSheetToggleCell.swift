//
//  PMActionSheetToggleCell.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 9/26/22.
//

import UIKit
import Foundation

protocol PMActionSheetToggleDelegate: AnyObject {
    func toggleTriggeredAt(indexPath: IndexPath)
}

final class PMActionSheetToggleCell: UITableViewCell, AccessibleView {
    // MARK: Constants
    private let PADDING: CGFloat = 16

    private let toggle: UISwitch
    private weak var delegate: PMActionSheetToggleDelegate?
    private var indexPath: IndexPath = IndexPath(row: -1, section: -1)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        self.toggle = UISwitch()
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        self.setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Public function
extension PMActionSheetToggleCell {
    func config(item: PMActionSheetToggleItem, at indexPath: IndexPath, delegate: PMActionSheetToggleDelegate) {
        self.backgroundColor = ColorProvider.BackgroundNorm
        self.imageView?.image = item.icon
        self.imageView?.tintColor = item.iconColor
        self.textLabel?.text = item.title
        self.textLabel?.textColor = item.textColor
        self.toggle.isOn = item.isOn
        self.toggle.onTintColor = item.toggleColor
        self.accessibilityIdentifier = "itemIndex_\(indexPath.section).\(indexPath.row)"
        self.accessibilityLabel = item.title
        self.indexPath = indexPath
        self.delegate = delegate
        generateAccessibilityIdentifiers()
    }
}

// MARK: Private function
extension PMActionSheetToggleCell {
    private func setup() {
        self.setupToggle()
        self.addSeparator(leftRef: self.textLabel!, constant: -16)
    }

    private func setupToggle() {
        self.toggle.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(self.toggle)
        self.toggle.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -1 * PADDING).isActive = true
        self.toggle.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        self.toggle.addTarget(self, action: #selector(self.triggerToggle), for: .valueChanged)
    }

    @objc private func triggerToggle() {
        self.delegate?.toggleTriggeredAt(indexPath: self.indexPath)
    }
}


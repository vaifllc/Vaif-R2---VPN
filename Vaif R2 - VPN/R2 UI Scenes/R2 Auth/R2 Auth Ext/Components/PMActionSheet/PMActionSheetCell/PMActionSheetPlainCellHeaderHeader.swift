//
//  PMActionSheetPlainCellHeaderHeader.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 9/21/22.
//

import UIKit


class PMActionSheetPlainCellHeader: UITableViewHeaderFooterView, LineSeparatable, Reusable, AccessibleView {
    private lazy var label = UILabel(nil, font: .systemFont(ofSize: 13),
                                     textColor: ColorProvider.TextWeak)
    private var separator: UIView?

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        setupBackground()
        setupLabel()
        generateAccessibilityIdentifiers()
    }

    func setupBackground() {
        contentView.backgroundColor = ColorProvider.BackgroundNorm
    }
    func setupLabel() {
        addSubview(label)
        label.centerXInSuperview(constant: 16)
        label.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
        label.topAnchor.constraint(equalTo: topAnchor, constant: 23).isActive = true
        label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15).isActive = true
        label.numberOfLines = 1
        label.backgroundColor = ColorProvider.BackgroundNorm
        separator = addSeparator(padding: 0)
    }

    func config(title: String) {
        label.text = Settings.actionSheetSectionTitleTransformation(title: title)
    }
}


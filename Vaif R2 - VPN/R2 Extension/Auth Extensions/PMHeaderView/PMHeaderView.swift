//
//  PMHeaderView.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 9/26/22.
//

import Foundation
import UIKit


public final class PMHeaderView: UIView, AccessibleView {

    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var titleLabelLeft: NSLayoutConstraint!
    @IBOutlet private var titleLabelBottom: NSLayoutConstraint!
    @IBOutlet private var contentView: UIView!
    private let title: String
    private let fontSize: CGFloat
    private let titleColor: UIColor
    private let titleLeft: CGFloat
    private let titleBottom: CGFloat
    private let background: UIColor

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public init(title: String,
                fontSize: CGFloat = 15,
                titleColor: UIColor = ColorProvider.TextWeak,
                titleLeft: CGFloat = 16,
                titleBottom: CGFloat = 8,
                background: UIColor = ColorProvider.BackgroundSecondary) {
        self.title = title
        self.fontSize = fontSize
        self.titleColor = titleColor
        self.titleLeft = titleLeft
        self.titleBottom = titleBottom
        self.background = background
        super.init(frame: .zero)
        self.nibSetup()
    }
}

extension PMHeaderView {
    private func nibSetup() {
        self.contentView = loadViewFromNib()
        self.contentView.frame = bounds
        self.contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.contentView.translatesAutoresizingMaskIntoConstraints = true

        addSubview(self.contentView)
        self.setup()
        generateAccessibilityIdentifiers()
    }

    private func loadViewFromNib() -> UIView {
        let bundle = PMUIFoundations.bundle
        let name = String(describing: PMHeaderView.self)
        let nib = UINib(nibName: name, bundle: bundle)
        let nibView = nib.instantiate(withOwner: self, options: nil).first as! UIView

        return nibView
    }

    private func setup() {
        self.contentView.backgroundColor = self.background
        self.titleLabel.text = self.title
        self.titleLabel.textColor = self.titleColor
        self.titleLabel.font = .systemFont(ofSize: self.fontSize)
        self.titleLabelLeft.constant = self.titleLeft
        self.titleLabelBottom.constant = self.titleBottom
    }
}

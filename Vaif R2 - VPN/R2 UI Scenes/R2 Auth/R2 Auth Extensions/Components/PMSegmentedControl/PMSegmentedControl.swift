//
//  PMSegmentedControl.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 9/21/22.
//

import UIKit

public final class PMSegmentedControl: UISegmentedControl, AccessibleView {

    private let defaultFont = UIFont.systemFont(ofSize: 14)
    private let defaultColor: UIColor = ColorProvider.TextNorm

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }

    override public init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    init() {
        super.init(frame: .zero)
        configure()
    }

    public func setImage(image: UIImage, withText: String, forSegmentAt: Int) {
        let embeddedImage = UIImage.textEmbeded(image: image, string: withText, font: defaultFont)
        setImage(embeddedImage, forSegmentAt: forSegmentAt)
    }

    private func configure() {
        let titleTextAttributes = [NSAttributedString.Key.foregroundColor: defaultColor, NSAttributedString.Key.font: defaultFont]
        setTitleTextAttributes(titleTextAttributes, for: .selected)
        setTitleTextAttributes(titleTextAttributes, for: .normal)
        
        backgroundColor = ColorProvider.SeparatorNorm
        if #available(iOS 13.0, *) {
            selectedSegmentTintColor = ColorProvider.BackgroundNorm
        } else {
            tintColor = ColorProvider.BackgroundNorm
        }
        generateAccessibilityIdentifiers()
    }
}


//
//  SubtitleLabel.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 9/26/22.
//

import Foundation
import UIKit

final class SubtitleLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    private func setup() {
        textColor = ColorProvider.TextWeak
        font = UIFont.systemFont(ofSize: 15)
        setLineHeight(lineHeight: 1.2)
    }
}


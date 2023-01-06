//
//  ConfirmationToggleSwitch.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 12/28/22.
//

import Foundation
import UIKit

final class ConfirmationToggleSwitch: UISwitch {
    var tapped: (() -> Void)?

    private let button = UIButton()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    private func setup() {
        button.translatesAutoresizingMaskIntoConstraints = false
        addFillingSubview(button)

        button.addTarget(self, action: #selector(switchTapped(sender:)), for: .touchUpInside)
    }

    @objc private func switchTapped(sender: UIButton) {
        tapped?()
    }
}


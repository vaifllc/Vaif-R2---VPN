//
//  UIStackView+helper.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 9/26/22.
//

import UIKit
import Foundation

extension UIStackView {
    convenience init(_ _axis: NSLayoutConstraint.Axis,
                     alignment _alignment: UIStackView.Alignment,
                     distribution _distribution: UIStackView.Distribution,
                     useAutoLayout: Bool = false) {
        self.init(frame: .zero)
        axis = _axis
        alignment = _alignment
        distribution = _distribution
        translatesAutoresizingMaskIntoConstraints = !useAutoLayout
    }
}


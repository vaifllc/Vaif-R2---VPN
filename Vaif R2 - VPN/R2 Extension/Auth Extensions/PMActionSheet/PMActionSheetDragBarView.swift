//
//  PMActionSheetDragBarView.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 9/26/22.
//

import Foundation
import UIKit

final class PMActionSheetDragBarView: UIView, AccessibleView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setup()
    }

}

extension PMActionSheetDragBarView {
    private func setup() {
        self.setupBar()
        self.backgroundColor = ColorProvider.BackgroundNorm
        generateAccessibilityIdentifiers()
    }

    private func setupBar() {
        let bar = UIView(frame: .zero)
        bar.backgroundColor = ColorProvider.InteractionWeakPressed
        bar.roundCorner(2)
        self.addSubview(bar)
        bar.setSizeContraint(height: 4, width: 40)
        bar.centerXInSuperview()
        bar.centerYInSuperview()
    }
}


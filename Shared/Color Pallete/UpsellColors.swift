//
//  UpsellColors.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 9/28/22.
//

import Foundation
import UIKit
import Modals_iOS

struct UpsellColors: ModalsColors {
    var background: UIColor
    var secondaryBackground: UIColor
    var text: UIColor
    var textAccent: UIColor
    var brand: UIColor
    var weakText: UIColor
    var weakInteraction: UIColor

    init() {
        background = UIColor.backgroundColor()
        secondaryBackground = UIColor.secondaryBackgroundColor()
        text = UIColor.normalTextColor()
        textAccent = UIColor.textAccent()
        brand = UIColor.brandColor()
        weakText = UIColor.weakTextColor()
        weakInteraction = UIColor.weakInteractionColor()
    }
}

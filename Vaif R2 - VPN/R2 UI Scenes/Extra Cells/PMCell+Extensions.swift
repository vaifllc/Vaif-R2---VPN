//
//  PMCell+Extensions.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 9/28/22.
//

import Foundation
import UIKit

extension PMCell {
    func configure(item: HelpItem) {
        title = item.description
        icon = item.icon
    }
}

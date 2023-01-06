//
//  TabBar.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 12/28/22.
//

import UIKit

class TabBar: UITabBar {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        isTranslucent = false
    }
}

extension TabBar {
    
    override var traitCollection: UITraitCollection {
        return UITraitCollection(traitsFrom: [super.traitCollection] + [UITraitCollection(horizontalSizeClass: .compact)])
    }
}

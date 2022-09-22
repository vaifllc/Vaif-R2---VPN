//
//  PMBannerPosition.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 9/21/22.
//

import UIKit

public enum PMBannerPosition {
    case top
    case bottom
    case topCustom(UIEdgeInsets)
    case bottomCustom(UIEdgeInsets)

    public var edgeInsets: UIEdgeInsets {
        switch self {
        case .top:
            return UIEdgeInsets(top: 8, left: 16, bottom: CGFloat.infinity, right: 16)
        case .bottom:
            return UIEdgeInsets(top: CGFloat.infinity, left: 8, bottom: 21, right: 8)
        case .topCustom(let insets):
            return insets
        case .bottomCustom(let insets):
            return insets
        }
    }
}


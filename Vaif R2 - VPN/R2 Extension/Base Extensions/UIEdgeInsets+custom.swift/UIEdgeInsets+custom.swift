//
//  UIEdgeInsets+custom.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 10/12/22.
//

import UIKit

public extension UIEdgeInsets {
    static var baner: UIEdgeInsets {
        return UIEdgeInsets(top: 24, left: 24, bottom: .infinity, right: 24)
    }

    static var saveAreaBottom: CGFloat {
        return UIApplication.getInstance()?.keyWindow?.safeAreaInsets.bottom ?? 0
    }
}


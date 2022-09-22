//
//  UIView+helper.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 9/21/22.
//

import UIKit
public extension UIView {
    var safeGuide: UIEdgeInsets {
        guard #available(iOS 11.0, *) else {
            // Device has physical home button
            return UIEdgeInsets.zero
        }
        return self.safeAreaInsets
    }

    func roundCorner(_ radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }

    func getKeyboardHeight() -> CGFloat {

        guard let application = UIApplication.getInstance() else {
            return 0
        }

        let keyboardWindow = application.windows.first(where: {
            let desc = $0.description.lowercased()
            return desc.contains("keyboard")
        })
        guard let rootVC = keyboardWindow?.rootViewController else {
            return 0
        }
        for sub in rootVC.view.subviews {
            guard sub.description.contains("UIInputSetHostView") else {
                continue
            }
            return sub.frame.size.height
        }
        return 0
    }
    
    func asImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: frame.size)
        return renderer.image { context in
            layer.render(in: context.cgContext)
        }
    }
}


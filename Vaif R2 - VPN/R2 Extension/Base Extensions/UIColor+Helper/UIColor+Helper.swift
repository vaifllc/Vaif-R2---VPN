//
//  UIColor+Helper.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 9/26/22.
//

import UIKit

extension UIColor {
    
    public class func dynamic(lightRGB: Int, lightAlpha: CGFloat, darkRGB: Int, darkAlpha: CGFloat) -> UIColor {
        dynamic(light: UIColor(rgb: lightRGB, alpha: lightAlpha), dark: UIColor(rgb: darkRGB, alpha: darkAlpha))
    }
    
    public static func dynamic(light: UIColor, dark: UIColor) -> UIColor {
        var dynamicColor: UIColor = .clear
        if #available(iOS 13.0, *) {
            dynamicColor = UIColor(dynamicProvider: {
                switch $0.userInterfaceStyle {
                case .dark:
                    return dark
                case .light, .unspecified:
                    return light
                @unknown default:
                    assertionFailure("Unknown userInterfaceStyle: \($0.userInterfaceStyle)")
                    return light
                }
            })
        }
        return darkModeAwareValue { dynamicColor } protonFallback: { light } vpnFallback: { dark }
    }
}

public extension UIColor {
    convenience init(red: Int, green: Int, blue: Int, alpha: CGFloat = 1.0) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        assert(alpha >= 0.0 && alpha <= 1.0, "Invalid alpha component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: alpha)
    }
    
    convenience init(rgb: Int, alpha: CGFloat = 1.0) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF,
            alpha: alpha
        )
    }
}


//
//  UIColor+Extension.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 9/26/22.
//

import Foundation
import UIKit


extension UIColor {
    
    static func == (lhs: UIColor, rhs: UIColor) -> Bool {
        guard let lhsComponents = lhs.cgColor.components, let rhsComponents = rhs.cgColor.components else {
            return false
        }
        
        let errorMargian: CGFloat = 0.0001
        let red = lhsComponents[0] < rhsComponents[0] + errorMargian && lhsComponents[0] > rhsComponents[0] - errorMargian
        let green = lhsComponents[1] < rhsComponents[1] + errorMargian && lhsComponents[1] > rhsComponents[1] - errorMargian
        let blue = lhsComponents[2] < rhsComponents[2] + errorMargian && lhsComponents[2] > rhsComponents[2] - errorMargian
        let alpha = lhsComponents[3] < rhsComponents[3] + errorMargian && lhsComponents[3] > rhsComponents[3] - errorMargian
        
        return red && green && blue && alpha
    }

    class func brandColor() -> UIColor {
        return ColorProvider.BrandNorm
    }

    class func textAccent() -> UIColor {
        return ColorProvider.TextAccent
    }

    class func interactionNorm() -> UIColor {
        return ColorProvider.InteractionNorm
    }
    
    class func brandLighten20Color() -> UIColor {
        return ColorProvider.BrandLighten20
    }
    
    class func brandLighten40Color() -> UIColor {
        return ColorProvider.BrandLighten40
    }
    
    class func brandDarken40Color() -> UIColor {
        return ColorProvider.BrandDarken40
    }

    class func secondaryBackgroundColor() -> UIColor {
        return ColorProvider.BackgroundSecondary
    }

    class func backgroundColor() -> UIColor {
        return ColorProvider.BackgroundNorm
    }

    class func weakTextColor() -> UIColor {
        return ColorProvider.TextWeak
    }

    class func weakInteractionColor() -> UIColor {
        return ColorProvider.InteractionWeak
    }
    
    class func normalSeparatorColor() -> UIColor {
        return ColorProvider.SeparatorNorm
    }
    
    class func notificationWarningColor() -> UIColor {
        return ColorProvider.NotificationWarning
    }
    
    class func notificationOKColor() -> UIColor {
        return ColorProvider.NotificationSuccess
    }

    class func normalTextColor() -> UIColor {
        return ColorProvider.TextNorm
    }

    class func iconWeak() -> UIColor {
        return ColorProvider.IconWeak
    }

    class func iconHint() -> UIColor {
        return ColorProvider.IconHint
    }

    class func iconNorm() -> UIColor {
        return ColorProvider.IconNorm
    }

    class func iconAccent() -> UIColor {
        return ColorProvider.IconAccent
    }
    
    class func notificationErrorColor() -> UIColor {
        return ColorProvider.NotificationError
    }
}

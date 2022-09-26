//
//  PMBannerNewStyle.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 9/26/22.
//

import Foundation
import UIKit

public enum PMBannerNewStyle: PMBannerStyleProtocol {
    case success
    case warning
    case error
    case info

    /// Color of banner background
    public var bannerColor: UIColor {
        switch self {
        case .success:
            return ColorProvider.NotificationSuccess
        case .warning:
            return ColorProvider.NotificationWarning
        case .error:
            return ColorProvider.NotificationError
        case .info:
            return ColorProvider.NotificationNorm
        }
    }

    /// Color of banner text message
    public var bannerTextColor: UIColor {
        switch self {
        case .success:
            return Settings.bannerTextColorSuccess
        case .error:
            return Settings.bannerTextColorError
        case .warning:
            return Settings.bannerTextColorWarning
        case .info:
            return ColorProvider.TextInverted
        }
    }

    /// Color of assist button background
    public var assistBgColor: UIColor {
        switch self {
        case .success, .warning, .error:
            return ColorProvider.White.withAlphaComponent(0.2)
        case .info:
            return Settings.bannerAssistBgColorInfo
        }
    }

    /// Color of assist highlighted button background
    public var assistHighBgColor: UIColor {
        switch self {
        case .success, .warning, .error:
            return ColorProvider.White.withAlphaComponent(0.4)
        case .info:
            return Settings.bannerAssistassistHighBgColorInfo
        }
    }

    /// Color of assist button text
    public var assistTextColor: UIColor {
        switch self {
        case .success:
            return Settings.bannerTextColorSuccess
        case .error:
            return Settings.bannerTextColorError
        case .warning:
            return Settings.bannerTextColorWarning
        case .info:
            return ColorProvider.TextInverted
        }
    }

    /// Color of banner icon
    public var bannerIconColor: UIColor {
        switch self {
        case .success, .warning, .error:
            return ColorProvider.White
        case .info:
            return ColorProvider.IconInverted
        }
    }

    /// Color of banner icon background
    public var bannerIconBgColor: UIColor {
        switch self {
        case .success, .warning, .error, .info:
            return UIColor.clear
        }
    }

    /// Lock swipe if button is shown
    public var lockSwipeWhenButton: Bool {
        return false
    }

    /// Banner border radius
    public var borderRadius: CGFloat {
        return 6
    }

    /// Banner paddings
    public var borderInsets: UIEdgeInsets {
        return UIEdgeInsets(top: 14, left: 16, bottom: 14, right: 12)
    }

    /// Message font
    public var messageFont: UIFont {
        return .systemFont(ofSize: 15)
    }

    /// Button font
    public var buttonFont: UIFont {
        return .systemFont(ofSize: 15)
    }

    /// Button vertical alignment
    public var buttonVAlignment: ButtonVAlignment {
        return .center
    }

    /// Button margin to the banner border
    public var buttonMargin: CGFloat {
        return 16
    }

    /// Button tittle paddings
    public var buttonInsets: UIEdgeInsets? {
        return UIEdgeInsets(top: 8, left: 12, bottom: 8, right: 12)
    }
}

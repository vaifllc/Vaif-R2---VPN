//
//  PMBannerStyle.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 9/26/22.
//

import Foundation
import UIKit

public enum ButtonVAlignment {
    case center
    case bottom
}

public protocol PMBannerStyleProtocol {
    var bannerColor: UIColor { get }
    var bannerTextColor: UIColor { get }
    var assistBgColor: UIColor { get }
    var assistHighBgColor: UIColor { get }
    var assistTextColor: UIColor { get }
    var bannerIconColor: UIColor { get }
    var bannerIconBgColor: UIColor { get }

    var lockSwipeWhenButton: Bool { get }
    var borderRadius: CGFloat { get }
    var borderInsets: UIEdgeInsets { get }
    var messageFont: UIFont { get }
    var buttonFont: UIFont { get }
    var buttonVAlignment: ButtonVAlignment { get }
    var buttonMargin: CGFloat { get }
    var buttonInsets: UIEdgeInsets? { get }
}

extension PMBannerStyleProtocol {

    /// Lock swipe if button is shown
    public var lockSwipeWhenButton: Bool {
        return false
    }

    /// Banner border radius
    public var borderRadius: CGFloat {
        return 8
    }

    /// Banner paddings
    public var borderInsets: UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    }

    /// Message font
    public var messageFont: UIFont {
        return .boldSystemFont(ofSize: 15)
    }

    /// Button font
    public var buttonFont: UIFont {
        return .systemFont(ofSize: 13)
    }

    /// Button vertical alignment
    public var buttonVAlignment: ButtonVAlignment {
        return .bottom
    }

    /// Button padding to the right banner edge
    public var buttonMargin: CGFloat {
        return 13
    }

    /// Button tittle paddings
    public var buttonInsets: UIEdgeInsets? {
        return nil
    }
}

@available(*, deprecated, message: "Please use PMBannerNewStyle")
public enum PMBannerStyle: PMBannerStyleProtocol {
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
        case .success, .warning, .error, .info:
            return UIColor.white
        }
    }

    /// Color of assist button background
    public var assistBgColor: UIColor {
        switch self {
        case .success, .warning, .error, .info:
            return UIColor(red: 1, green: 1, blue: 1, alpha: 0.2)
        }
    }

    /// Color of assist hightlighted button background
    public var assistHighBgColor: UIColor {
        switch self {
        case .success, .warning, .error, .info:
            return UIColor(red: 1, green: 1, blue: 1, alpha: 0.2)
        }
    }

    /// Color of assist button text
    public var assistTextColor: UIColor {
        switch self {
        case .success, .warning, .error, .info:
            return UIColor.white
        }
    }

    /// Color of banner icon
    public var bannerIconColor: UIColor {
        switch self {
        case .success, .warning, .error, .info:
            return UIColor.white
        }
    }

    /// Color of banner icon background
    public var bannerIconBgColor: UIColor {
        switch self {
        case .success, .warning, .error, .info:
            return UIColor.clear
        }
    }

    /// Button position inside view
    public var radius: Float {
        return 4
    }

    /// Button position inside view
    public var buttonVAlignment: ButtonVAlignment {
        return .bottom
    }

}

//
//  HelpItem.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 9/26/22.
//

import Foundation
import UIKit


public enum HelpItem {
    case forgotUsername
    case forgotPassword
    case otherIssues
    case support
    case staticText(text: String)
    case custom(icon: UIImage, title: String, behaviour: (UIViewController) -> Void)
}

extension HelpItem: CustomStringConvertible {
    public var description: String {
        switch self {
        case .forgotUsername:
            return CoreString._ls_help_forgot_username
        case .forgotPassword:
            return CoreString._ls_help_forgot_password
        case .otherIssues:
            return CoreString._ls_help_other_issues
        case .support:
            return CoreString._ls_help_customer_support
        case .staticText(let text):
            return text
        case let .custom(_, title, _):
            return title
        }
    }
}

extension HelpItem {
    public var icon: UIImage? {
        switch self {
        case .forgotUsername:
            return IconProvider.userCircle
        case .forgotPassword:
            return IconProvider.key
        case .otherIssues:
            return IconProvider.questionCircle
        case .support:
            return IconProvider.speechBubble
        case .staticText:
            return nil
        case let .custom(icon, _, _):
            return icon
        }
    }
}


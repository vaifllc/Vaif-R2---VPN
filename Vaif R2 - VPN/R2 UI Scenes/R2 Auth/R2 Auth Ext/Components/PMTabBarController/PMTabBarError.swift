//
//  PMTabBarError.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 9/21/22.
//

import Foundation

enum PMTabBarError: Error, LocalizedError {
    case configMissing
    case countNotEqual
    case emptyItemAndVC
    case cannotUpdate

    var localizedDescription: String {
        switch self {
        case .configMissing:
            return "Tabbar config is missing"
        case .countNotEqual:
            return "Count of bar items and viewcontrollers is not equal"
        case .emptyItemAndVC:
            return "Haven't set tab bar items and viewcontrollers"
        case .cannotUpdate:
            return "Can't update this value after initialization"
        }
    }
}


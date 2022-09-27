//
//  UIConstants.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 9/26/22.
//

import Foundation
import GSMessages
import UIKit

class UIConstants {
    
    // MARK: - Cell constants
    static let connectionStatusCellHeight: CGFloat = 48
    static let cellHeight: CGFloat = 52.5
    static let headerHeight: CGFloat = 56
    static let countriesHeaderHeight: CGFloat = 40
    static let connectionBarHeight: CGFloat = 44
    
    // MARK: - Messages
    static let messageOptions: [GSMessageOption] = [
        .animations([.slide(.normal)]),
        .animationDuration(0.3),
        .autoHide(true),
        .autoHideDelay(4.0),
        .cornerRadius(0.0),
        .height(44.0),
        .hideOnTap(true),
        .margin(.zero),
        .padding(.init(top: 10, left: 15, bottom: 10, right: 15)),
        .position(.top),
        .textAlignment(.center),
        .textColor(.white),
        .textNumberOfLines(0),
    ]
    
    static let maxProfileNameLength = 25
}

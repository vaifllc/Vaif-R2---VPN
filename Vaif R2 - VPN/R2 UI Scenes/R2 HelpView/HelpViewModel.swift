//
//  HelpViewModel.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 9/28/22.
//

import Foundation
import UIKit
final class HelpViewModel {
    
    let helpSections: [[HelpItem]]

    init(helpDecorator: ([[HelpItem]]) -> [[HelpItem]]) {
        let defaultHelp: [[HelpItem]] = [
            [
                .forgotUsername,
                .forgotPassword,
                .otherIssues
            ],
            [
                .staticText(text: CoreString._ls_help_more_help)
            ],
            [
                .support
            ]
        ]
        helpSections = helpDecorator(defaultHelp)
    }
}

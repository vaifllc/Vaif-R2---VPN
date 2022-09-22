//
//  LoginUIImages.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 9/21/22.
//

import UIKit
import Foundation

enum LoginUIImages {
    
    static var brandIconForProton: UIImage? {
        nil
    }
    
    static var brandIconForVPN: UIImage? {
        nil
    }
    
    static var summaryImage: UIImage? {
        nil
    }
    
    static var summaryWhole: UIImage? {
        IconProvider.summary
    }
    
    static var brandLogo: UIImage? {
        IconProvider.masterBrandBrand
    }
    
    static var animationFile: String {
        "sign-up-create-account-V5"
    }
    
    static func welcomeAnimationFile(variant: WelcomeScreenVariant) -> String {
        switch variant {
        case .mail, .custom: return "welcome_animation_mail"
        case .vpn: return "welcome_animation_vpn"
        case .calendar: return "welcome_animation_calendar"
        case .drive: return "welcome_animation_drive"
        }
    }
}

public extension SignupParameters {
    
    init(separateDomainsButton: Bool = true,
         passwordRestrictions: SignupPasswordRestrictions,
         summaryScreenVariant: SummaryScreenVariant) {
        self.init(separateDomainsButton, passwordRestrictions, summaryScreenVariant)
    }
}


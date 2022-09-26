//
//  SplashScreenViewControllerFactory.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 9/26/22.
//

import UIKit

public enum SplashScreenIBVariant: Int {
    case mail = 1
    case calendar = 2
    case drive = 3
    case vpn = 4
}

public enum SplashScreenViewControllerFactory {
    
    public static func instantiate(for variant: SplashScreenIBVariant) -> UIViewController {
        let storyboardName: String
        switch variant {
        case .mail:
            storyboardName = "MailLaunchScreen"
        case .drive:
            storyboardName = "DriveLaunchScreen"
        case .calendar:
            storyboardName = "CalendarLaunchScreen"
        case .vpn:
            storyboardName = "VPNLaunchScreen"
        }
        let storyboard = UIStoryboard(name: storyboardName, bundle: .main)
        guard let splash = storyboard.instantiateInitialViewController() else {
            assertionFailure("Cannot instantiate launch screen view controller")
            return UIViewController(nibName: nil, bundle: nil)
        }
        return splash
    }
    
}


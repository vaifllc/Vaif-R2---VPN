//
//  UIViewController+Helper.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 9/26/22.
//

import Foundation
import UIKit

extension UIViewController {
    public func lockUI() {
        enableUserInteraction(enable: false)
    }

    public func unlockUI() {
        enableUserInteraction(enable: true)
    }

    private func enableUserInteraction(enable: Bool) {
        view.window?.isUserInteractionEnabled = enable
    }
}

public extension UIViewController {
    
    var isPresentedModally: Bool {
        if let navigationController = navigationController {
            if navigationController.viewControllers.first != self {
                return false
            }
        }
        
        if presentingViewController != nil {
            return true
        }
        
        if navigationController?.presentingViewController?.presentedViewController == navigationController {
            return true
        }
        
        if tabBarController?.presentingViewController is UITabBarController {
            return true
        }
        
        return false
    }
    
    @IBAction func dismissViewController(_ sender: Any) {
        if #available(iOS 13.0, *) {
            if let presentationController = navigationController?.presentationController {
                presentationController.delegate?.presentationControllerDidDismiss?(presentationController)
            }
        }
        navigationController?.dismiss(animated: true)
    }

    func setUpCloseButton(showCloseButton: Bool, action: Selector?) {
        if showCloseButton {
            let closeButton = UIBarButtonItem(image: IconProvider.crossSmall, style: .plain, target: self, action: action)
            closeButton.tintColor = ColorProvider.IconNorm
            navigationItem.setHidesBackButton(true, animated: false)
            navigationItem.setLeftBarButton(closeButton, animated: true)
            navigationItem.assignNavItemIndentifiers()
        }
    }

    func setUpBackArrow(action: Selector?) {
        let backButton = UIBarButtonItem(image: IconProvider.arrowLeft, style: .plain, target: self, action: action)
        backButton.tintColor = ColorProvider.IconNorm
        navigationItem.setHidesBackButton(true, animated: false)
        navigationItem.setLeftBarButton(backButton, animated: true)
        navigationItem.assignNavItemIndentifiers()
    }
    
    func updateTitleAttributes() {
        let foregroundColor: UIColor = ColorProvider.TextNorm
        let textAttributes = [NSAttributedString.Key.foregroundColor: foregroundColor]
        if #available(iOS 13.0, *) {
            let appearance = navigationController?.navigationBar.standardAppearance
            appearance?.titleTextAttributes = textAttributes
            navigationController?.navigationBar.scrollEdgeAppearance = appearance
        } else {
            navigationController?.navigationBar.titleTextAttributes = textAttributes
        }
    }

}


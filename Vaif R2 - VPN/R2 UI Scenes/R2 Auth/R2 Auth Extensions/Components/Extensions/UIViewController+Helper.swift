//
//  UIViewController+Helper.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 9/21/22.
//

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
            let appearance = navigationController?.navigationBar.standardAppearance
            appearance?.titleTextAttributes = textAttributes
            navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }

}


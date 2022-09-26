//
//  PopupDialogButtonExt.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 9/19/22.
//

import Foundation
import NetworkExtension
import CocoaLumberjackSwift
import UIKit
import PromiseKit
import StoreKit
import SwiftyStoreKit
import PopupDialog
import AwesomeSpotlightView

fileprivate extension PopupDialogButton {
    func startActivityIndicator() {
        let activity = UIActivityIndicatorView()
        
        if let label = titleLabel {
            label.addSubview(activity)
            activity.translatesAutoresizingMaskIntoConstraints = false
            activity.centerYAnchor.constraint(equalTo: label.centerYAnchor).isActive = true
            activity.leadingAnchor.constraint(equalToSystemSpacingAfter: label.trailingAnchor, multiplier: 1).isActive = true
            activity.startAnimating()
        }
    }
    
    func stopActivityIndicator() {
        if let label = titleLabel {
            let indicators = label.subviews.compactMap { $0 as? UIActivityIndicatorView }
            for indicator in indicators {
                indicator.stopAnimating()
                indicator.removeFromSuperview()
            }
        }
    }
}

final class DynamicButton: PopupDialogButton {
    var onTap: ((DynamicButton) -> ())?
    
    override var buttonAction: PopupDialogButton.PopupDialogButtonAction? {
        get {
            if let onTap = onTap {
                return { [weak self] in if let value = self { return onTap(value) } }
            } else {
                return nil
            }
        }
    }
}

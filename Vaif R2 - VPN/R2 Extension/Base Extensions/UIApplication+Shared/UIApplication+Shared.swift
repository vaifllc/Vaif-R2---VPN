//
//  UIApplication+Shared.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 9/26/22.
//

import Foundation
import UIKit

public extension UIApplication {
    /// A hacky way to get shared instance
    /// UIApplication.shared can't be used in share extension
    
    
    static func getInstance() -> UIApplication? {
        return UIApplication.value(forKeyPath: #keyPath(UIApplication.shared)) as? UIApplication
    }
    
    var isSplitOrSlideOver: Bool {
        guard let window = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first else {
            return false
            
        }

        return !(window.frame.width == window.screen.bounds.width) && !(window.frame.width == window.screen.bounds.height)
    }
    
    class func topViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return topViewController(base: nav.visibleViewController)
        }
        
        if let tab = base as? UITabBarController {
            if let selected = tab.selectedViewController {
                return topViewController(base: selected)
            }
        }
        
        if let presented = base?.presentedViewController {
            return topViewController(base: presented)
        }
        
        return base
    }

    static func openURLIfPossible(_ url: URL) {
        let selector = #selector(self.openURL(_:))
        if UIApplication.getInstance()?.responds(to: selector) == true {
            UIApplication.getInstance()?.perform(selector, with: url as NSURL)
        }
    }
}

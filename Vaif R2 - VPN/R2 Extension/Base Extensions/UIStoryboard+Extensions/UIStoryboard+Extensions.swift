//
//  UIStoryboard+Extensions.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 9/26/22.
//

import Foundation
import UIKit

extension UIStoryboard {
    static func instantiate<T: UIViewController>(storyboardName: String, controllerType: T.Type) -> T {
        let storyboard = UIStoryboard(name: storyboardName, bundle: LoginAndSignup.bundle)
        let name = "\(controllerType)".replacingOccurrences(of: "ViewController", with: "")
        let viewController = storyboard.instantiateViewController(withIdentifier: name) as! T
        return viewController
    }
}

//
//  UIKit+Extensions.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 9/19/22.
//

import UIKit

extension UIDevice {
    
    static var is4InchIphone: Bool {
        return UIScreen.main.nativeBounds.height == 1136
    }
}

extension Bundle {
    var versionString: String {
        return "v" + (infoDictionary?["CFBundleShortVersionString"] as? String ?? "")
    }
}

extension UIStoryboard {
    func instantiate<ViewController: UIViewController>(_ viewControllerType: ViewController.Type) -> ViewController {
        let identifier = String.init(describing: viewControllerType)
        if let resolved = instantiateViewController(withIdentifier: identifier) as? ViewController {
            return resolved
        } else {
            fatalError("No ViewController with Storyboard ID = \(identifier). Please make sure your Storyboard ID is the same as class name!")
        }
    }
}


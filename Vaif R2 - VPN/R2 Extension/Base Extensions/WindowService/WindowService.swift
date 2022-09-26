//
//  WindowService.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 9/26/22.
//

import Foundation
import UIKit
import GSMessages

protocol WindowServiceFactory {
    func makeWindowService() -> WindowService
}

protocol WindowService: AnyObject {

    func show(viewController: UIViewController)
    func addToStack(_ controller: UIViewController, checkForDuplicates: Bool)
    func popStackToRoot()
    var navigationStackAvailable: Bool { get }
    
    func present(modal: UIViewController)
    func dismissModal(_ completion: (() -> Void)?)
    
    func present(alert: UIAlertController)
    func present(message: String, type: PresentedMessageType, accessibilityIdentifier: String?)
}

/// GSMessageType wrapper
enum PresentedMessageType {
    case error
    case success
    
    var gsMessageType: GSMessageType {
        switch self {
        case .error: return GSMessageType.error
        case .success: return GSMessageType.success
        }
    }
}

class WindowServiceImplementation: WindowService {
    
    private let window: UIWindow
    
    init (window: UIWindow) {
        self.window = window

        if ProcessInfo.processInfo.arguments.contains("UITests") {
            window.layer.speed = 100
        }
        
        setupAppearance()
    }
    
    func setupAppearance() {
        window.tintColor = .brandColor()
        
        UINavigationBar.appearance().barTintColor = .backgroundColor()
        UINavigationBar.appearance().tintColor = .normalTextColor()
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.normalTextColor()]
        UINavigationBar.appearance().isTranslucent = false
        
        UITabBar.appearance().backgroundColor = .secondaryBackgroundColor()
        UITabBar.appearance().barTintColor = .secondaryBackgroundColor()
        UITabBar.appearance().tintColor = .iconAccent()
        UITabBar.appearance().unselectedItemTintColor = .iconWeak()
        UITabBar.appearance().isTranslucent = false

        UISwitch.appearance().onTintColor = .brandColor()
        
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.textAccent()], for: .selected)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.weakTextColor()], for: .normal)
        
        UIPageControl.appearance().pageIndicatorTintColor = UIColor.secondaryBackgroundColor()
        UIPageControl.appearance().currentPageIndicatorTintColor = .brandColor()
        
        GSMessage.successBackgroundColor = UIColor.brandColor()
        GSMessage.warningBackgroundColor = UIColor.notificationWarningColor()
        GSMessage.errorBackgroundColor = UIColor.notificationErrorColor()
        
        if #available(iOS 15.0, *) { // Removes unnecessary padding at the top of tables
            UITableView.appearance().sectionHeaderTopPadding = 0.0
        }
    }
    
    // MARK: - Presentation
    
    func show(viewController: UIViewController) {
        window.rootViewController = viewController
        window.makeKeyAndVisible()
    }
    
    func addToStack(_ controller: UIViewController, checkForDuplicates: Bool = false) {
        guard let navigationController = topMostNavigationController() else {
            return
        }
        
        guard checkForDuplicates else {
            navigationController.pushViewController(controller, animated: true)
            return
        }
        
        for existingController in navigationController.viewControllers {
            if object_getClassName(controller) == object_getClassName(existingController) {
                return // Don't add two controllers of the same class
            }
        }
        
        navigationController.pushViewController(controller, animated: true)
    }
    
    func popStackToRoot() {
        let navigationController = topMostNavigationController()
        navigationController?.popToRootViewController(animated: true)
    }
    
    var navigationStackAvailable: Bool {
        return topMostNavigationController() != nil
    }
    
    // MARK: - Modal presentation
    
    func present(modal: UIViewController) {
        topmostPresentedViewController?.present(modal, animated: true, completion: nil)
    }
    
    func dismissModal(_ completion: (() -> Void)? = nil) {
        DispatchQueue.main.async {
            if let rootViewController = self.window.rootViewController {
                if let topViewController = rootViewController.presentedViewController {
                    topViewController.dismiss(animated: true, completion: completion)
                } else {
                    rootViewController.dismiss(animated: true, completion: completion)
                }
            }
        }
    }
    
    // MARK: - Alerts
    
    func present(alert: UIAlertController) {
        presentAlertFromAppropriateViewController(alert: alert)
    }
    
    func present(message: String, type: PresentedMessageType, accessibilityIdentifier: String?) {
        let options = accessibilityIdentifier != nil ? UIConstants.messageOptions + [.accessibilityIdentifier(accessibilityIdentifier!)] : UIConstants.messageOptions
        topmostPresentedViewController?.showMessage(message, type: type.gsMessageType, options: options)
    }
    
    // MARK: - Private functions
    
    private func presentAlertFromAppropriateViewController(alert: UIAlertController) {
        topmostPresentedViewController?.present(alert, animated: true, completion: nil)
    }
    
    private var topmostPresentedViewController: UIViewController? {
        guard let rootViewController = window.rootViewController else {
            return nil
        }
        var controller = rootViewController
        while let childController = controller.presentedViewController {
            controller = childController
        }
        return controller
    }
    
    private func topMostNavigationController() -> UINavigationController? {
        guard let rootViewController = window.rootViewController else { return nil }
        var navigationController: UINavigationController?
        if let topViewController = rootViewController.presentedViewController as? UINavigationController {
            navigationController = topViewController
        } else if let tabBarController = rootViewController as? TabBarController, let topViewController = tabBarController.selectedViewController as? UINavigationController {
            navigationController = topViewController
        } else {
            navigationController = rootViewController as? UINavigationController
        }
        
        // Search for modally presented controllers
        if navigationController == nil {
            var controller = rootViewController
            while let modal = controller.presentedViewController {
                controller = modal
            }
            navigationController = controller as? UINavigationController
        }
        
        while let modal = navigationController?.presentedViewController as? UINavigationController {
            navigationController = modal
        }
        return navigationController
    }
}

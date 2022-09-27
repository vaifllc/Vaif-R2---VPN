//
//  WelcomeViewCoordinator.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 9/26/22.
//

import Foundation
import UIKit
import Lottie

public protocol WelcomeViewCoordinatorDelegate: AnyObject {
    func userWantsToLogIn(username: String?)
    func userWantsToSignUp()
}

public final class WelcomeViewCoordinator {

    private let rootViewController: UIViewController
    private let variant: WelcomeScreenVariant
    private let username: String?
    private let signupAvailable: Bool
    public weak var delegate: WelcomeViewCoordinatorDelegate?
    
    var navigationViewController: LoginNavigationViewController?
    var animationViewController: WelcomeAnimationViewController?
    var welcomeViewController: WelcomeViewController?
    
    public init(rootViewController: UIViewController, variant: WelcomeScreenVariant, username: String?, signupAvailable: Bool) {
        self.rootViewController = rootViewController
        self.variant = variant
        self.username = username
        self.signupAvailable = signupAvailable
    }
    
    public func start() {
        showAnimationViewController()
    }
    
    private func showAnimationViewController() {
        let animationViewController = WelcomeAnimationViewController(variant: variant) { [weak self] in
            guard let self = self else { return }
            let welcomeViewController = WelcomeViewController(
                variant: self.variant, delegate: self, username: self.username, signupAvailable: self.signupAvailable
            )
            self.welcomeViewController = welcomeViewController
            self.navigationViewController?.setViewControllers([welcomeViewController], animated: true)
        }
        self.animationViewController = animationViewController
        animationViewController.modalPresentationStyle = .fullScreen
        let navigationViewController = getNavigationViewController(rootViewController: animationViewController)
        self.navigationViewController = navigationViewController
        rootViewController.present(navigationViewController, animated: false)
    }

    private func getNavigationViewController(rootViewController: UIViewController) -> LoginNavigationViewController {
        let navigationViewController = LoginNavigationViewController(rootViewController: rootViewController, navigationBarHidden: true)
        navigationViewController.autoresettingNextTransitionStyle = .fade
        navigationViewController.modalTransitionStyle = .coverVertical
        return navigationViewController
    }
}

extension WelcomeViewCoordinator: WelcomeViewControllerDelegate {
        
    public func userWantsToLogIn(username: String?) {
        dismiss { [weak self] in
            self?.delegate?.userWantsToLogIn(username: username)
        }
    }
        
    public func userWantsToSignUp() {
        dismiss { [weak self] in
            self?.delegate?.userWantsToSignUp()
        }
    }
        
    private func dismiss(completion: @escaping () -> Void) {
        welcomeViewController?.dismiss(animated: false) { [weak self] in
            self?.animationViewController?.dismiss(animated: false) {
                completion()
            }
        }
    }
}

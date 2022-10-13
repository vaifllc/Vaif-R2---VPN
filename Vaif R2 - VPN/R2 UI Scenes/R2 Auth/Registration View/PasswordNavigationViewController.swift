//
//  PasswordNavigationViewController.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 10/12/22.
//

import Foundation
import UIKit


public final class PasswordNavigationViewController: DarkModeAwareNavigationViewController, AccessibleView {

    public enum TransitionStyle {
        case systemDefault
        case modalLike
        case fade
    }

    public var autoresettingNextTransitionStyle: TransitionStyle = .systemDefault

    public init(rootViewController: UIViewController, navigationBarHidden: Bool = false) {
        super.init(rootViewController: rootViewController)
        delegate = self
        modalPresentationStyle = .fullScreen
        setUpShadowLessNavigationBar()
        setNavigationBarHidden(navigationBarHidden, animated: false)
        generateAccessibilityIdentifiers()
    }
    
    override public init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    override public var childForStatusBarStyle: UIViewController? { topViewController }

    override public var preferredStatusBarUpdateAnimation: UIStatusBarAnimation { .fade }

    public func popToRootViewController(animated: Bool, completion: @escaping () -> Void) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        self.popToRootViewController(animated: animated)
        CATransaction.commit()
    }

    public func setUpShadowLessNavigationBar() {
        baseNavigationBarConfiguration()
        if #available(iOS 13.0, *) {
            navigationBar.standardAppearance.shadowImage = .colored(with: .clear)
        } else {
            navigationBar.shadowImage = .colored(with: .clear)
        }
    }

    public func setUpNavigationBarWithShadow() {
        baseNavigationBarConfiguration()
        if #available(iOS 13.0, *) {
            navigationBar.standardAppearance.shadowImage = .colored(with: ColorProvider.Shade20)
        } else {
            navigationBar.shadowImage = .colored(with: ColorProvider.Shade20)
        }
    }

    private func baseNavigationBarConfiguration() {
        let color = topViewController?.view.backgroundColor ?? .clear
        navigationBar.isTranslucent = false
        if #available(iOS 13.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithTransparentBackground()
            appearance.backgroundColor = color
            navigationBar.standardAppearance = appearance
            navigationBar.scrollEdgeAppearance = navigationBar.standardAppearance
        } else {
            navigationBar.setBackgroundImage(.colored(with: color), for: .default)
            navigationBar.backgroundColor = .clear
        }
    }
}

extension PasswordNavigationViewController: UINavigationControllerDelegate {
    public func navigationController(_ navigationController: UINavigationController,
                                     animationControllerFor operation: UINavigationController.Operation,
                                     from fromVC: UIViewController,
                                     to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        defer { autoresettingNextTransitionStyle = .systemDefault }
        switch autoresettingNextTransitionStyle {
        case .modalLike: return ModalLikeTransition()
        case .fade:
            switch operation {
            case .push:
                return FadePushAnimator()
            default:
                return nil
            }
        case .systemDefault: return nil
        }
    }
}

fileprivate final class ModalLikeTransition: NSObject, UIViewControllerAnimatedTransitioning {

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval { 0.3 }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromViewController = transitionContext.viewController(forKey: .from),
              let toViewController = transitionContext.viewController(forKey: .to)
        else { return }
        let containerView = transitionContext.containerView

        let finalFrame = transitionContext.finalFrame(for: toViewController)
        toViewController.view.frame.origin.y = fromViewController.view.frame.maxY
        containerView.insertSubview(toViewController.view, aboveSubview: fromViewController.view)

        UIView.animate(withDuration: transitionDuration(using: transitionContext)) {
            toViewController.view.frame = finalFrame
        } completion: {
            toViewController.navigationController?.setNavigationBarHidden(false, animated: false)
            transitionContext.completeTransition($0)
        }
    }
}

private class FadePushAnimator: NSObject, UIViewControllerAnimatedTransitioning {

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1.0
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard
            let toViewController = transitionContext.viewController(forKey: .to)
        else {
            return
        }
        transitionContext.containerView.addSubview(toViewController.view)
        toViewController.view.alpha = 0

        let duration = self.transitionDuration(using: transitionContext)
        UIView.animate(withDuration: duration, animations: {
            toViewController.view.alpha = 1
        }, completion: { _ in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }
}


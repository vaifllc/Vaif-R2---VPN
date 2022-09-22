//
//  WelcomeViewController.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 9/22/22.
//

import UIKit
import func AVFoundation.AVMakeRect

public typealias WelcomeScreenVariant = ScreenVariant<WelcomeScreenTexts, WelcomeScreenCustomData>

public protocol WelcomeViewControllerDelegate: AnyObject {
    func userWantsToLogIn(username: String?)
    func userWantsToSignUp()
}

public final class WelcomeViewController: UIViewController, AccessibleView {

    private let variant: WelcomeScreenVariant
    private let username: String?
    private let signupAvailable: Bool
    private weak var delegate: WelcomeViewControllerDelegate?

    override public var preferredStatusBarStyle: UIStatusBarStyle { darkModeAwarePreferredStatusBarStyle() }

    public init(variant: WelcomeScreenVariant,
                delegate: WelcomeViewControllerDelegate,
                username: String?,
                signupAvailable: Bool) {
        self.variant = variant
        self.delegate = delegate
        self.username = username
        self.signupAvailable = signupAvailable
        super.init(nibName: nil, bundle: nil)
        self.extendedLayoutIncludesOpaqueBars = true
    }

    required init?(coder: NSCoder) { fatalError("not designed to be created from IB") }

    override public func loadView() {
        let loginAction = #selector(WelcomeViewController.loginActionWasPerformed)
        let signupAction = #selector(WelcomeViewController.signupActionWasPerformed)
        view = WelcomeView(variant: variant,
                           target: self,
                           loginAction: loginAction,
                           signupAction: signupAction,
                           signupAvailable: signupAvailable)
        generateAccessibilityIdentifiers()
    }

    @objc private func loginActionWasPerformed() {
        delegate?.userWantsToLogIn(username: username)
    }

    @objc private func signupActionWasPerformed() {
        delegate?.userWantsToSignUp()
    }
}


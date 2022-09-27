//
//  WelcomeAnimationViewController.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 9/26/22.
//

import Foundation
import UIKit
import Lottie

public final class WelcomeAnimationViewController: UIViewController {

    override public var preferredStatusBarStyle: UIStatusBarStyle { darkModeAwarePreferredStatusBarStyle() }

    public init(variant: WelcomeScreenVariant, finishHandler: (() -> Void)? = nil) {
        super.init(nibName: nil, bundle: nil)
        self.setupUI(variant: variant, finishHandler: finishHandler)
    }

    required init?(coder: NSCoder) {
        fatalError("not designed to be created from IB")
    }
    
    private func setupUI(variant: WelcomeScreenVariant, finishHandler: (() -> Void)?) {
        navigationItem.setHidesBackButton(true, animated: false)
        view.backgroundColor = ColorProvider.BackgroundNorm
        
        let animationView = createAnimationView(variant: variant, finishHandler: finishHandler)
        view.addSubview(animationView)
        animationView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: animationView.topAnchor),
            view.bottomAnchor.constraint(equalTo: animationView.bottomAnchor),
            view.leadingAnchor.constraint(equalTo: animationView.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: animationView.trailingAnchor)
        ])
    }
    
    private func createAnimationView(variant: WelcomeScreenVariant, finishHandler: (() -> Void)?) -> AnimationView {
        let animationView = AnimationView()
        animationView.animation = Animation.named(LoginUIImages.welcomeAnimationFile(variant: variant),
                                                  bundle: LoginAndSignup.bundle)
        animationView.loopMode = .playOnce
        animationView.backgroundBehavior = .pauseAndRestore
        animationView.play { _ in finishHandler?() }
        return animationView
    }
}

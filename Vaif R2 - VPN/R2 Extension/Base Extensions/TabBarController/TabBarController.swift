//
//  TabBarController.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 9/26/22.
//

import Foundation
import UIKit

final class TabBarController: UITabBarController, UITabBarControllerDelegate {

    private var quickConnectButtonConnecting = false
    private let quickConnectButton = UIButton()
    
    var viewModel: TabBarViewModel? {
        didSet {
            viewModel?.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegate = self
        setupView()
        setupQuickConnectView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        viewModel?.stateChanged()
    }

    func setupView() {
        view.backgroundColor = .backgroundColor()
        selectedIndex = 0
    }
    
    private func setupQuickConnectView() {
        quickConnectButton.backgroundColor = .clear
        quickConnectButton.layer.masksToBounds = true
        
        quickConnectButton.contentVerticalAlignment = .top
        quickConnectButton.contentHorizontalAlignment = .center
        quickConnectButton.imageView?.contentMode = .scaleAspectFit
        quickConnectButton.adjustsImageWhenHighlighted = false
        
        quickConnectButton.addTarget(self, action: #selector(quickConnectTapped), for: .touchUpInside)
        
        view.addSubview(quickConnectButton)
        
        let bottomItem: Any
        bottomItem = view.safeAreaLayoutGuide
        
        quickConnectButton.translatesAutoresizingMaskIntoConstraints = false
        let widthConstraint = NSLayoutConstraint(item: quickConnectButton, attribute: .width, relatedBy: .equal, toItem: tabBar, attribute: .width, multiplier: 1 / CGFloat(tabBar.items?.count ?? 5), constant: 4)
        let heightConstraint = NSLayoutConstraint(item: quickConnectButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 66)
        let centerXConstraint = NSLayoutConstraint(item: quickConnectButton, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0)
        let bottomConstraint = NSLayoutConstraint(item: quickConnectButton, attribute: .bottom, relatedBy: .equal, toItem: bottomItem, attribute: .bottom, multiplier: 1, constant: 6)
        view.addConstraints([widthConstraint, heightConstraint, centerXConstraint, bottomConstraint])

        disconnectedQuickConnect()
    }
    
    @objc private func quickConnectTapped(_ sender: UIButton) {
        viewModel?.quickConnectTapped()
    }
}

extension TabBarController: TabBarViewModelDelegate {
    func connectedQuickConnect() {
        quickConnectButtonConnecting = false
        self.tabBar.items?[2].setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.weakTextColor()], for: .normal)
        self.tabBar.items?[2].title = LocalizedString.disconnect
        self.quickConnectButton.setImage(UIImage(named: "quick-connect-active-button"), for: .normal)
    }
    
    func connectingQuickConnect() {
        if !quickConnectButtonConnecting { // to avoid animation jumping, don't reset animation during multiple connecting stage calls
            self.tabBar.items?[2].setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.textAccent()], for: .normal)
            self.tabBar.items?[2].title = LocalizedString.connecting
            self.quickConnectButton.setImage(UIImage(named: "quick-connect-connecting-button"), for: .normal)
        }
        
        quickConnectButtonConnecting = true
    }
    
    func disconnectedQuickConnect() {
//        quickConnectButtonConnecting = false
//        guard self.tabBar.items?.count > 2 else { return }
//        self.tabBar.items?[2].setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.weakTextColor()], for: .normal)
//        self.tabBar.items?[2].title = LocalizedString.quickConnect
//        self.quickConnectButton.setImage(UIImage(named: "quick-connect-inactive-button"), for: .normal)
    }
}

//extension TabBarController: UITabBarControllerDelegate {
//
//    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
//        // to help with data updating and easier to understand navigation, pop nvc to root
//        if let navigationViewController = viewController as? UINavigationController, navigationViewController != self.selectedViewController {
//            navigationViewController.popToRootViewController(animated: false)
//        }
//
//        if viewController is ProtonQCViewController {
//            return false
//        } else if let viewModel = viewModel, viewController == viewControllers?.last { // settings
//            return viewModel.settingShouldBeSelected()
//        } else {
//            return true
//        }
//    }
//}

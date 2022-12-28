//
//  R2TabbarController.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 12/23/22.
//

import UIKit
import CardTabBar

final class R2TabbarController: CardTabBarController {
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
        setupUI()
    }

    // MARK: - UI
    private func setupUI() {
        tabBar.tintColor = .white
        tabBar.backgroundColor = .backgroundColor()
        tabBar.barTintColor = .secondaryBackgroundColor()
        tabBar.unselectedItemTintColor = .white
        tabBar.indicatorColor = .backgroundColor()
    }
    
    private func setupViewController() {
        viewControllers = [homeTab, bookTab, editTab, notificationTab, moreTab]
    }

    // MARK: - TabItems
    lazy var homeTab: UIViewController = {
        let homeTabItem = UITabBarItem(title: "Home", image: UIImage(named: "ic_home")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal), selectedImage: nil)
        let homeNavTab = R2NavigationController(rootViewController: HomeViewController())
        homeNavTab.tabBarItem = homeTabItem
        return homeNavTab
    }()

    lazy var bookTab: UIViewController = {
        let searchTabItem = UITabBarItem(title: "Search", image: UIImage(named: "ic_search")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal), selectedImage: nil)
        let navController = R2NavigationController(rootViewController: HomeViewController())
        navController.tabBarItem = searchTabItem
        return navController
    }()

    lazy var editTab: UIViewController = {
        let randomTabItem = UITabBarItem(title: "Profile", image: UIImage(named: "ic_profile")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal), selectedImage: nil)
        let navController = R2NavigationController(rootViewController: HomeViewController())
        navController.tabBarItem = randomTabItem
        return navController
    }()

    lazy var notificationTab: UIViewController = {
        let commentTabItem = UITabBarItem(title: "Notice", image: UIImage(named: "ic_notifi")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal), selectedImage: nil)
        let navController = R2NavigationController(rootViewController: HomeViewController())
        navController.tabBarItem = commentTabItem
        return navController
    }()

    lazy var moreTab: UIViewController = {
        let commentTabItem = UITabBarItem(title: "More", image: UIImage(named: "ic_settings")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal), selectedImage: nil)
        let navController = R2NavigationController(rootViewController: HomeViewController())
        navController.tabBarItem = commentTabItem
        return navController
    }()
}

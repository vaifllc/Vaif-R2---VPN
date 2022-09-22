//
//  PMTabBarBuilder.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 9/21/22.
//

import UIKit

public final class PMTabBarBuilder {
    private var items: [PMTabBarItem] = []
    private var height: CGFloat = 48
    private var backgroundColor: UIColor = ColorProvider.FloatyBackground
    private var floatingHeight: CGFloat?
    private var vcs: [UIViewController] = []
    private var selectedIndex: Int = 0

    public init() {}

    /// Sets height of the tab bar controller, default value is `48`
    public func setTabBarHeight(_ height: CGFloat) -> PMTabBarBuilder {
        self.height = height
        return self
    }

    /// Sets background color of the tab bar controller, default value is `ColorProvider.FloatyBackground`
    public func setBackgroundColor(_ color: UIColor) -> PMTabBarBuilder {
        self.backgroundColor = color
        return self
    }

    /// Sets floating height of the tab bar controller
    /// - Parameter value: The floating distance between the tab bar and the bottom of the screen, default value is `nil`, which means the bar won't float.
    public func setFloatingHeight(_ value: CGFloat) -> PMTabBarBuilder {
        self.floatingHeight = value
        return self
    }

    /// The index of the selected tab item when initializing. default value is `0`
    public func setSelectedIndex(_ idx: Int) -> PMTabBarBuilder {
        self.selectedIndex = idx
        return self
    }

    /// Sets tab bar item and view controller pairs
    public func addItem(_ item: PMTabBarItem, withController vc: UIViewController) -> PMTabBarBuilder {
        self.items.append(item)
        self.vcs.append(vc)
        return self
    }

    /// Build an instance of `PMTabBarController` by the previous configuration.
    public func build() throws -> PMTabBarController {
        guard self.items.count > 0, self.vcs.count > 0 else {
            throw PMTabBarError.emptyItemAndVC
        }

        let config = PMTabBarConfig(items: self.items,
                                    height: self.height,
                                    backgroundColor:
                                        self.backgroundColor,
                                    floatingHeight: self.floatingHeight)
        let barVC = PMTabBarController()
        try barVC.setupConfig(config)
        barVC.setViewControllers(self.vcs, animated: false)
        barVC.selectedIndex = self.selectedIndex
        return barVC
    }
}


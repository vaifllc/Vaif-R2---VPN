//
//  NavigationBarAdjustingScrollViewDelegate.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 9/26/22.
//

import UIKit
import Foundation

public final class NavigationBarAdjustingScrollViewDelegate: NSObject, UIScrollViewDelegate {

    private var shouldAdjustNavigationBar = true

    private weak var navigationController: LoginNavigationViewController?

    public func setUp(for scrollView: UIScrollView, shouldAdjustNavigationBar: Bool = true, parent: UIViewController?) {
        guard let navigationController = parent as? LoginNavigationViewController else { return }
        scrollView.delegate = self
        self.navigationController = navigationController
        self.shouldAdjustNavigationBar = shouldAdjustNavigationBar
    }

    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard shouldAdjustNavigationBar, let navigationController = navigationController else { return }
        let adjustedTopOffset = scrollView.contentOffset.y
        if adjustedTopOffset <= .zero {
            navigationController.setUpShadowLessNavigationBar()
        } else {
            navigationController.setUpNavigationBarWithShadow()
        }
    }
}


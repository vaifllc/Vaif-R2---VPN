//
//  HomeViewController+Ext.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 12/31/22.
//

import FloatingPanel

// MARK: - FloatingPanelControllerDelegate -

extension HomeViewController: FloatingPanelControllerDelegate {
    
    func floatingPanel(_ vc: FloatingPanelController, layoutFor newCollection: UITraitCollection) -> FloatingPanelLayout? {
        updateAccessibilityLabel(vc: vc)
        
        return FloatingPanelMainLayout()
    }
    
    func floatingPanelShouldBeginDragging(_ vc: FloatingPanelController) -> Bool {
        return UIDevice.current.userInterfaceIdiom == .pad && UIApplication.shared.statusBarOrientation.isLandscape && !UIApplication.shared.isSplitOrSlideOver ? false : true
    }
    
    func floatingPanelDidChangePosition(_ vc: FloatingPanelController) {
        updateAccessibilityLabel(vc: vc)
    }
    
    func updateAccessibilityLabel(vc: FloatingPanelController) {
        if let controlPanelViewController = floatingPanel.contentViewController, UIDevice.current.userInterfaceIdiom != .pad {
            if vc.position == .full {
                controlPanelViewController.view.accessibilityLabel = "Swipe down to collapse control panel"
            } else {
                controlPanelViewController.view.accessibilityLabel = "Swipe up to expan control panel"
            }
        }
    }
    
}

// MARK: - UIAdaptivePresentationControllerDelegate -

extension HomeViewController: UIAdaptivePresentationControllerDelegate {
    
    func presentationControllerWillDismiss(_ presentationController: UIPresentationController) {
        floatingPanel.updateLayout()
        NotificationCenter.default.post(name: Notification.Name.UpdateControlPanel, object: nil)
    }
    
    func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        if let controlPanelViewController = floatingPanel.contentViewController {
            NotificationCenter.default.removeObserver(controlPanelViewController, name: Notification.Name.ServiceAuthorized, object: nil)
            NotificationCenter.default.removeObserver(controlPanelViewController, name: Notification.Name.SubscriptionActivated, object: nil)
        }
    }
    
}

// MARK: - VPNErrorObserverDelegate -

//extension MainViewController: VPNErrorObserverDelegate {
//
//    func presentError(title: String, message: String) {
//        showErrorAlert(title: title, message: message)
//    }
//
//}

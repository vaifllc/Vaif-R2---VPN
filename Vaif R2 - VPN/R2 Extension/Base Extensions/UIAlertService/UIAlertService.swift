//
//  UIAlertService.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 9/27/22.
//

import Foundation
import UIKit

class IosUiAlertService: UIAlertService {
    
    //private let planService: PlanService?
    private let windowService: WindowService
    private var currentAlerts = [SystemAlert]()
    
    public init(windowService: WindowService) {
        self.windowService = windowService
       // self.planService = planService
    }
    
    func displayAlert(_ alert: SystemAlert) {
        guard alertIsNew(alert) else {
            updateOldAlert(with: alert)
            return
        }
        
        currentAlerts.append(alert)
        displayTrackedAlert(alert: alert)
    }
    
    func displayAlert(_ alert: SystemAlert, message: NSAttributedString) {
        alert.message = message.string
        displayAlert(alert)
    }
    
    func displayNotificationStyleAlert(message: String, type: NotificationStyleAlertType, accessibilityIdentifier: String?) {
        windowService.present(message: message, type: type.presentedMessageType, accessibilityIdentifier: accessibilityIdentifier)
    }
    
    private func alertIsNew(_ alert: SystemAlert) -> Bool {
        return !currentAlerts.contains(where: { (currentAlert) -> Bool in
            return currentAlert.className == alert.className
        })
    }
    
    private func updateOldAlert(with newAlert: SystemAlert) {
        let oldAlert = currentAlerts.first { alert -> Bool in
            return alert.className == newAlert.className
        }
    
        // In particular this means the alert's completion handlers will be updated
        oldAlert?.actions = newAlert.actions
    }
    
    private func dismissCompletion(_ alert: SystemAlert) -> (() -> Void) {
        return { [weak self] in
            self?.currentAlerts.removeAll { currentAlert in
                return currentAlert.className == alert.className
            }
        }
    }
    
    private func displayTrackedAlert( alert: SystemAlert ) {
        let alertController = TrackedAlertController(title: alert.title, message: alert.message, preferredStyle: .alert)
        alert.actions.forEach { action in
            alertController.addAction(UIAlertAction(title: action.title, style: action.style.alertButtonStyle, handler: { _ in
                action.handler?()
            }))
        }
        
        alertController.dismissCompletion = self.dismissCompletion(alert)
        alert.dismiss = {
            alertController.dismiss(animated: true, completion: nil)
        }
        
        self.windowService.present(alert: alertController)
    }
}

extension PrimaryActionType {
    
    var alertButtonStyle: UIAlertAction.Style {
        switch self {
        case .confirmative, .secondary:
            return .default
        case .destructive:
            return .destructive
        case .cancel:
            return .cancel
        }
    }
    
}

extension NotificationStyleAlertType {
    var presentedMessageType: PresentedMessageType {
        switch self {
        case .error: return PresentedMessageType.error
        case .success: return PresentedMessageType.success
        }
    }
}

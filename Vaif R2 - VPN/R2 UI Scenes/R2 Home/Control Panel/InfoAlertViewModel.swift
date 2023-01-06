//
//  InfoAlertViewModel.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 1/2/23.
//

import UIKit

class InfoAlertViewModel {
    
    // MARK: - Properties -
    
    var text: String {
        switch infoAlert {
        case .subscriptionExpiration:
            let days = Application.shared.serviceStatus.daysUntilSubscriptionExpiration()
            let activeUntilExpired = Application.shared.serviceStatus.activeUntilExpired()
            
            if days == 0 {
                if !activeUntilExpired {
                    return "Subscription expires today"
                }
                
                if !Application.shared.serviceStatus.isActive {
                    return "Subscription expired"
                }
            }
            
            if days == 1 {
                return "Subscription will expire in \(days) day"
            }
            
            return "Subscription will expire in \(days) days"
        case .connectionInfoFailure:
            return "Loading connection info failed"
        }
    }
    
    var actionText: String {
        switch infoAlert {
        case .subscriptionExpiration:
            return "RENEW"
        case .connectionInfoFailure:
            return "RETRY"
        }
    }
    
    var type: InfoAlertViewType {
        switch infoAlert {
        case .subscriptionExpiration:
            return .alert
        case .connectionInfoFailure:
            return .alert
        }
    }
    
    var shouldDisplay: Bool {
        if infoAlert == .connectionInfoFailure {
            return true
        }
      
//        if Application.shared.serviceStatus.isLegacyAccount() {
//            return false
//        }
        
//        if Application.shared.authentication.isLoggedIn && infoAlert == .subscriptionExpiration && Application.shared.serviceStatus.isActiveUntilValid() && Application.shared.serviceStatus.daysUntilSubscriptionExpiration() <= 3 {
//            return true
//        }
        
        return false
    }
    
    var infoAlert: InfoAlert = .subscriptionExpiration
    
}

// MARK: - InfoAlertViewModel extension -

extension InfoAlertViewModel {
    
    enum InfoAlert {
        case subscriptionExpiration
        case connectionInfoFailure
    }
    
}

// MARK: - InfoAlertViewDelegate -

extension InfoAlertViewModel: InfoAlertViewDelegate {
    
    func action() {
        guard shouldDisplay else {
            return
        }
        
        switch infoAlert {
        case .subscriptionExpiration:
//            if let topViewController = UIApplication.topViewController() as? MainViewController {
//                topViewController.present(NavigationManager.getSubscriptionViewController(), animated: true, completion: nil)
//            }
            print("expired")
        case .connectionInfoFailure:
            NotificationCenter.default.post(name: Notification.Name.UpdateGeoLocation, object: nil)
        }
    }
    
}


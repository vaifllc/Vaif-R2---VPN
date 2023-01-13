//
//  PaywallService+Ext.swift
//  VaifR2
//
//  Created by VAIF on 1/6/23.
//

import StoreKit
import Paywall

// MARK: - Paywall Delegate
extension PaywallService: PaywallDelegate {
  // 1
  func purchase(product: SKProduct) {
    // TODO: Purchase the product here
  }

  // 2
  func restorePurchases(completion: @escaping (Bool) -> Void) {
    // TODO: Restore purchases and call completion block with boolean indicating
    // the success status of restoration
    completion(false)
  }

  // 3
  func isUserSubscribed() -> Bool {
    // TODO: Replace with boolean indicating the user's subscription status
    return false
  }
}

//
//  PaywallService.swift
//  VaifR2
//
//  Created by VAIF on 1/6/23.
//

import Paywall

final class PaywallService {
  static let apiKey = "pk_cde295fd509967b4a1573e3245b095c931f5b3434cd70d85" // Replace this with your API Key
  static var shared = PaywallService()

  static func initPaywall() {
    let options = PaywallOptions()
    // Uncomment to show debug logs
    // options.logging.level = .debug

    Paywall.configure(
      apiKey: apiKey,
      delegate: shared,
      options: options
    )
  }
}

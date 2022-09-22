//
//  ChallengeProtocol.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 9/21/22.
//

import Foundation
#if canImport(UIKit)
import UIKit
#endif

public enum ChallengeTextFieldType {
    /// TextField for username
    case username
    case username_email
    /// TextField for password
    case password
    /// TextField for password confirm
    case confirm
    /// TextField for recovery mail
    case recoveryMail
    /// TextField for recovery phone
    case recoveryPhone
    /// TextField for verification
    case verification
}

public protocol ChallengeProtocol {

  #if canImport(UIKit)
  func observeTextField(_ textField: UITextField, type: ChallengeTextFieldType, ignoreDelegate: Bool) throws
  #endif
}

extension ChallengeProtocol {
  #if canImport(UIKit)
  public func observeTextField(_ textField: UITextField, type: ChallengeTextFieldType) throws {
    try observeTextField(textField, type: type, ignoreDelegate: false)
  }
  #endif
}


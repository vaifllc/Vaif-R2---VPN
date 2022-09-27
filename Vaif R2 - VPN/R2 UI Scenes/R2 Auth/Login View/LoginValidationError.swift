//
//  LoginValidationError.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 9/26/22.
//

import Foundation


enum LoginValidationError: Error, Equatable {
    case emptyUsername
    case emptyPassword
}

extension LoginValidationError: CustomStringConvertible {
    var description: String {
        switch self {
        case .emptyUsername:
            return CoreString._ls_validation_invalid_username
        case .emptyPassword:
            return CoreString._ls_validation_invalid_password
        }
    }
}

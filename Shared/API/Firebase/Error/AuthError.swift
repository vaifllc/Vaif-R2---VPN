//
//  AuthError.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 12/20/22.
//


import Foundation

enum AuthError {
    case notFilled
    case invalidEmail
    case passwordsNotMatched
    case unknownError
    case serverError
}

extension AuthError: LocalizedError {
    
    var errorDescription: String? {
        
        switch self {
        case .notFilled:
            return NSLocalizedString("Fill in all the fields.", comment: "")
        case .invalidEmail:
            return NSLocalizedString("Incorrect email.", comment: "")
        case .passwordsNotMatched:
            return NSLocalizedString("Passwords are not matching", comment: "")
        case .unknownError:
            return NSLocalizedString("An error has occured. Please, try once again.", comment: "")
        case .serverError:
            return NSLocalizedString("A server error has occured. Please, try again later.", comment: "")
        }
    }
    
}

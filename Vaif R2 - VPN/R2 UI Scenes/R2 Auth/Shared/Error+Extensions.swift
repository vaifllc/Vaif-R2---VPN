//
//  Error+Extensions.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 9/29/22.
//

import Foundation


extension LoginError {
    public var description: String {
        switch self {
        case let .generic(message: message, _, _):
            return message
        case let .invalidCredentials(message: message):
            return message
        case let .invalid2FACode(message):
            return message
        case let .invalidAccessToken(message):
            return message
        case let .initialError(message):
            return message
        case .invalidSecondPassword:
            return ""
        case .invalidState:
            return ""
        case .missingKeys:
            return ""
        case .needsFirstTimePasswordChange:
            return ""
        case .emailAddressAlreadyUsed:
            return ""
        case .missingSubUserConfiguration:
            return ""
        }
    }
}

public extension AuthErrors {

    func asLoginError(in2FAContext: Bool = false) -> LoginError {
        switch self {
        case .networkingError(let responseError):
            if responseError.httpCode == 401 {
                return .invalidAccessToken(message: responseError.localizedDescription)
            }
            if responseError.responseCode == 8002 {
                return in2FAContext
                    ? .invalid2FACode(message: responseError.localizedDescription)
                    : .invalidCredentials(message: responseError.localizedDescription)
            }
            return .generic(message: responseError.networkResponseMessageForTheUser,
                            code: codeInNetworking,
                            originalError: responseError)
        default:
            return .generic(message: userFacingMessageInNetworking,
                            code: codeInNetworking,
                            originalError: self)
        }
    }

    func asAvailabilityError() -> AvailabilityError {
        switch self {
        case .networkingError(let responseError) where responseError.responseCode == 12106:
            return .notAvailable(message: localizedDescription)
        default:
            return .generic(message: userFacingMessageInNetworking, code: codeInNetworking, originalError: self)
        }
    }

    func asSetUsernameError() -> SetUsernameError {
        switch self {
        case .networkingError(let responseError) where responseError.responseCode == 2011:
            return .alreadySet(message: localizedDescription)
        default:
            return .generic(message: userFacingMessageInNetworking, code: codeInNetworking, originalError: self)
        }
    }

    func asCreateAddressKeysError() -> CreateAddressKeysError {
        .generic(message: userFacingMessageInNetworking, code: codeInNetworking, originalError: self)
    }
}


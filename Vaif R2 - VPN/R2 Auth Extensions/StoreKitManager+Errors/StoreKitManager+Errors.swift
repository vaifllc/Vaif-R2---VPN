//
//  StoreKitManager+Errors.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 9/22/22.
//

import Foundation


public enum StoreKitManagerErrors: LocalizedError, Equatable {
    case unavailableProduct
    case invalidPurchase
    case receiptLost
    case haveTransactionOfAnotherUser
    case alreadyPurchasedPlanDoesNotMatchBackend
    case noActiveUsername
    case transactionFailedByUnknownReason
    case noNewSubscriptionInSuccessfullResponse
    case wrongTokenStatus(PaymentToken.Status)
    case notAllowed
    case unknown(code: Int, originalError: NSError)
    case appIsLocked
    case pleaseSignIn
    
    @available(*, deprecated, message: "This is never returned anymore — the success callback with `.resolvingIAPToCredits` is returned instead")
    static var creditsApplied: StoreKitManagerErrors { .transactionFailedByUnknownReason }
    
    @available(*, deprecated, message: "This is never returned anymore — the success callback with `.cancelled` is returned instead")
    static var cancelled: StoreKitManagerErrors { .transactionFailedByUnknownReason }
    
    var isUnknown: Bool {
        switch self {
        case .unknown: return true
        default: return false
        }
    }

    public var errorDescription: String? {
        switch self {
        case .unavailableProduct: return CoreString._error_unavailable_product
        case .invalidPurchase: return CoreString._error_invalid_purchase
        case .receiptLost: return CoreString._error_reciept_lost
        case .haveTransactionOfAnotherUser: return CoreString._error_another_user_transaction
        case .alreadyPurchasedPlanDoesNotMatchBackend: return CoreString._error_backend_mismatch
        case .noActiveUsername: return CoreString._error_no_active_username_in_user_data_service
        case .transactionFailedByUnknownReason: return CoreString._error_transaction_failed_by_unknown_reason
        case .noNewSubscriptionInSuccessfullResponse: return CoreString._error_no_new_subscription_in_response
        case .appIsLocked: return CoreString._error_unlock_to_proceed_with_iap
        case .pleaseSignIn: return CoreString._error_please_sign_in_iap
        case .wrongTokenStatus: return CoreString._error_wrong_token_status
        case .notAllowed, .unknown: return nil
        }
    }
}

extension Error {
    public var userFacingMessageInPayments: String {
        if let storeKitError = self as? StoreKitManagerErrors {
            return storeKitError.errorDescription ?? storeKitError.localizedDescription
        }
        return messageForTheUser
    }
}


//
//  ProtonApiError.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 9/28/22.
//

import Foundation

public enum ParseError: LocalizedError {
    
    case authInfoParse
    case authCredentialsParse
    case modulusParse
    case refreshTokenParse
    case vpnCredentialsParse
    case userIpParse
    case serverParse
    case sessionCountParse
    case loadsParse
    case clientConfigParse
    case subscriptionsParse
    case verificationMethodsParse
    case createPaymentTokenParse
    case stringToDataConversion
    
    public var localizedDescription: String {
        switch self {
        case .serverParse:
            return LocalizedString.errorServerInfoParser
        case .sessionCountParse:
            return LocalizedString.errorSessionCountParser
        case .loadsParse:
            return LocalizedString.errorLoads
        case .subscriptionsParse:
            return LocalizedString.errorSubscriptionParser
        case .verificationMethodsParse:
            return LocalizedString.errorVerificationMethodsParser
        default:
            return LocalizedString.errorInternalError
        }
    }
}

public class ApiError: NSError {
    
    public let httpStatusCode: Int
    public let responseBody: JSONDictionary?
    
    init(domain: String? = nil, httpStatusCode: Int, code: Int, localizedDescription: String? = nil, responseBody: JSONDictionary? = nil) {
        self.httpStatusCode = httpStatusCode
        self.responseBody = responseBody
        
        let errorMessage = ApiError.errorMessageFor(httpStatusCode: httpStatusCode, apiErrorCode: code, errorMessage: localizedDescription)
        let userInfo: [String: String] = [NSLocalizedDescriptionKey: errorMessage]
        super.init(domain: NSError.protonVpnErrorDomain, code: code, userInfo: userInfo)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public static let unknownError = ApiError(httpStatusCode: HttpStatusCode.internalServerError, code: HttpStatusCode.internalServerError,
                                             localizedDescription: LocalizedString.errorInternalError)
    
    private static func errorMessageFor(httpStatusCode statusCode: Int, apiErrorCode code: Int, errorMessage: String?) -> String {
        switch code {
        case ApiErrorCode.wrongLoginCredentials:
            return LocalizedString.aeWrongLoginCredentials
        case ApiErrorCode.vpnIpNotFound:
            return LocalizedString.aeVpnInfoNotReceived
        case ApiErrorCode.apiOffline:
            return LocalizedString.errorApiOffline
        default:
            return errorMessage ?? LocalizedString.errorInternalError
        }
    }
}


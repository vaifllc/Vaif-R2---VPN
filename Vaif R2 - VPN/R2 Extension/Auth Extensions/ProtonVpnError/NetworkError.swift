//
//  NetworkError.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 9/30/22.
//

import Foundation


public class NetworkError {
    
    private static let requestTimedOut = NSError(code: NetworkErrorCode.timedOut,
                                                 localizedDescription: LocalizedString.neRequestTimedOut)
    private static let cannotConnectToHost = NSError(code: NetworkErrorCode.cannotConnectToHost,
                                                     localizedDescription: LocalizedString.neUnableToConnectToHost)
    private static let networkConnectionLost = NSError(code: NetworkErrorCode.networkConnectionLost,
                                                       localizedDescription: LocalizedString.neNetworkConnectionLost)
    private static let notConnectedToInternet = NSError(code: NetworkErrorCode.notConnectedToInternet,
                                                        localizedDescription: LocalizedString.neNotConnectedToTheInternet)
    private static let tls = NSError(code: NetworkErrorCode.tls,
                                     localizedDescription: LocalizedString.errorMitmDescription)
    
    public static func error(forCode code: Int) -> NSError {
        let error: NSError
        switch code {
        case NetworkErrorCode.timedOut:
            error = requestTimedOut
        case NetworkErrorCode.cannotConnectToHost:
            error = cannotConnectToHost
        case NetworkErrorCode.networkConnectionLost:
            error = networkConnectionLost
        case NetworkErrorCode.notConnectedToInternet:
            error = notConnectedToInternet
        case NetworkErrorCode.tls:
            error = tls
        default:
            // FUTURETODO::fix error
            error = NSError(code: code, localizedDescription: LocalizedString.neCouldntReachServer)
        }
        return error
    }
}

extension Error {
    
    public var isNetworkError: Bool {
        let nsError = self as NSError
        switch nsError.code {
        case NetworkErrorCode.timedOut,
             NetworkErrorCode.cannotConnectToHost,
             NetworkErrorCode.networkConnectionLost,
             NetworkErrorCode.notConnectedToInternet,
             NetworkErrorCode.cannotFindHost,
             NetworkErrorCode.DNSLookupFailed,
             -1200, 451, 310,
             8 // No internet
             :
            return true
        default:
            return false
        }
    }
    
    public var isTlsError: Bool {
        let nsError = self as NSError
        switch nsError.code {
        case NetworkErrorCode.tls:
            return true
        default:
            return false
        }
    }
    
}

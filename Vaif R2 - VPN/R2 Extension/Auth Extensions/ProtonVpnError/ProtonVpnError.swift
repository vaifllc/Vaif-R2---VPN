//
//  ProtonVpnError.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 9/30/22.
//

import Foundation

// The errors happend locally
public enum ProtonVpnError: LocalizedError {
    
    // Hash pwd part
    case modulusSignature
    case generateSrp
    case hashPassword
    case fetchSession
    
    // VPN properties
    case vpnProperties
    
    // Decode
    case decode(location: String)
    
    // Connections
    case connectionFailed
    case vpnManagerUnavailable
    case removeVpnProfileFailed
    case tlsInitialisation
    case tlsServerVerification
    
    // Keychain
    case keychainWriteFailed
    
    // User
    case subuserWithoutSessions
    
    // MARK: -
    
    public var errorDescription: String? {
        switch self {
        case .modulusSignature:
            return LocalizedString.errorModulusSignature
        case .generateSrp:
            return LocalizedString.errorGenerateSrp
        case .hashPassword:
            return LocalizedString.errorHashPassword
        case .fetchSession:
            return LocalizedString.errorFetchSession
        case .vpnProperties:
            return LocalizedString.errorVpnProperties
        case .decode(let location):
            return LocalizedString.errorDecode(location)
        case .connectionFailed:
            return LocalizedString.connectionFailed
        case .vpnManagerUnavailable:
            return "Couldn't retrieve vpn manager"
        case .removeVpnProfileFailed:
            return "Failed to remove VPN profile"
        case .tlsInitialisation:
            return LocalizedString.errorTlsInitialisation
        case .tlsServerVerification:
            return LocalizedString.errorTlsServerVerification
        case .keychainWriteFailed:
            return LocalizedString.errorKeychainWrite
        case .subuserWithoutSessions:
            return LocalizedString.subuserAlertDescription1
        }
    }
}

public class ProtonVpnErrorConst {
    
    public static let vpnSessionInProgress = NSError(code: ErrorCode.vpnSessionInProgress,
                                              localizedDescription: LocalizedString.errorVpnSessionIsActive)
    public static let userHasNoVpnAccess = NSError(code: ErrorCode.userHasNoVpnAccess,
                                            localizedDescription: LocalizedString.errorUserHasNoVpnAccess)
    public static let userHasNotSignedUp = NSError(code: ErrorCode.userHasNotSignedUp,
                                            localizedDescription: LocalizedString.errorUserHasNotSignedUp)
    public static let userIsOnWaitlist = NSError(code: ErrorCode.userIsOnWaitlist,
                                          localizedDescription: LocalizedString.errorUserIsOnWaitlist)
    public static let userCredentialsMissing = NSError(code: ErrorCode.userCredentialsMissing,
                                                localizedDescription: LocalizedString.errorUserCredentialsMissing)
    public static let userCredentialsExpired = NSError(code: ErrorCode.userCredentialsExpired,
                                                localizedDescription: LocalizedString.errorUserCredentialsExpired)
    public static let vpnCredentialsMissing = NSError(code: ErrorCode.vpnCredentialsMissing,
                                               localizedDescription: LocalizedString.errorVpnCredentialsMissing)
}

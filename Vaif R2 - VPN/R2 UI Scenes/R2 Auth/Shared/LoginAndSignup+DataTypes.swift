//
//  LoginAndSignup+DataTypes.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 9/26/22.
//

import Foundation


public enum AccountType {
    case `internal`
    case external
    case username
}

public enum LoginData {
    case credential(Credential)
    case userData(UserData)
}

public extension LoginData {
    
    var credential: Credential {
        switch self {
        case .userData(let userData): return Credential(userData.credential, scope: userData.scopes)
        case .credential(let credential): return credential
        }
    }
    
    func updated(credential: Credential) -> LoginData {
        switch self {
        case .credential:
            return .credential(credential)
        case .userData(let userData):
            return .userData(UserData(credential: userData.credential.updatedKeepingKeyAndPasswordDataIntact(credential: credential),
                                      user: userData.user,
                                      salts: userData.salts,
                                      passphrases: userData.passphrases,
                                      addresses: userData.addresses,
                                      scopes: credential.scope))
        }
    }
    
    func updated(user: R2User) -> LoginData {
        switch self {
        case .credential: return self
        case .userData(let userData):
            return .userData(UserData(credential: userData.credential,
                                      user: user,
                                      salts: userData.salts,
                                      passphrases: userData.passphrases,
                                      addresses: userData.addresses,
                                      scopes: userData.scopes))
        }
    }
}

public struct UserData {
    public let credential: AuthCredential
    public let user: R2User
    public let salts: [KeySalt]
    public let passphrases: [String: String]
    public let addresses: [Address]
    public let scopes: [String]

    public init(credential: AuthCredential,
                user: R2User,
                salts: [KeySalt],
                passphrases: [String: String],
                addresses: [Address],
                scopes: [String]) {
        self.credential = credential
        self.user = user
        self.salts = salts
        self.passphrases = passphrases
        self.addresses = addresses
        self.scopes = scopes
    }

    public var toUserInfo: UserInfo {
        UserInfo(displayName: user.displayName,
                 maxSpace: Int64(user.maxSpace),
                 notificationEmail: nil,
                 signature: nil,
                 usedSpace: Int64(user.usedSpace),
                 userAddresses: addresses,
                 autoSC: nil,
                 language: nil,
                 maxUpload: Int64(user.maxUpload),
                 notify: nil,
                 showImage: nil,
                 swipeL: nil,
                 swipeR: nil,
                 role: user.role,
                 delinquent: user.delinquent,
                 keys: user.keys,
                 userId: user.ID,
                 sign: nil,
                 attachPublicKey: nil,
                 linkConfirmation: nil,
                 credit: user.credit,
                 currency: user.currency,
                 pwdMode: nil,
                 twoFA: nil,
                 enableFolderColor: nil,
                 inheritParentFolderColor: nil,
                 subscribed: user.subscribed,
                 groupingMode: nil,
                 weekStart: nil,
                 delaySendSeconds: nil)
    }
}

// API that doesn't return data as soon as possible
public enum LoginResult {
    case dismissed
    case loggedIn(LoginData)
    case signedUp(LoginData)
}

// API that returns data as soon as possible
public enum LoginState {
    case dataIsAvailable(LoginData)
    case loginFinished
}

public enum SignupState {
    case dataIsAvailable(LoginData)
    case signupFinished
}

public enum LoginAndSignupResult {
    case dismissed
    case loginStateChanged(LoginState)
    case signupStateChanged(SignupState)
}

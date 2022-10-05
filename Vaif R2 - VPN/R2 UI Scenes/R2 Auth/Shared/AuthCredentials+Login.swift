//
//  AuthCredentials+Login.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 10/4/22.
//

import Foundation

extension AuthCredentials {
    convenience init(_ data: LoginData) {
        switch data {
        case let .credential(credential):
            self.init(credential)
        case let .userData(userData):
            self.init(version: 0, username: userData.credential.userName, accessToken: userData.credential.accessToken, refreshToken: userData.credential.refreshToken, sessionId: userData.credential.sessionID, userId: userData.credential.userID, expiration: userData.credential.expiration, scopes: userData.scopes)
        }
    }
}


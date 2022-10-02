//
//  AuthKeychain.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 9/30/22.
//

import Foundation
import KeychainAccess

public protocol AuthKeychainHandle {
    func fetch(forContext: AppContext?) -> AuthCredentials?
    func store(_ credentials: AuthCredentials, forContext: AppContext?) throws
    func clear()
}

public extension AuthKeychainHandle {
    func fetch() -> AuthCredentials? {
        fetch(forContext: nil)
    }

    func store(_ credentials: AuthCredentials) throws {
        try store(credentials, forContext: nil)
    }
}

public protocol AuthKeychainHandleFactory {
    func makeAuthKeychainHandle() -> AuthKeychainHandle
}

public class AuthKeychain {
    public static let clearNotification = Notification.Name("AuthKeychain.clear")
    
    private struct StorageKey {
        static let authCredentials = "authCredentials"

        static let contextKeys: [AppContext: String] = [
            .mainApp: authCredentials,
            .wireGuardExtension: "\(authCredentials)_\(AppContext.wireGuardExtension)"
        ]
    }

    private static let `default`: AuthKeychainHandle = AuthKeychain(context: .mainApp)

    public static func fetch() -> AuthCredentials? {
        `default`.fetch()
    }
    
    public static func store(_ credentials: AuthCredentials) throws {
        try `default`.store(credentials)
    }
    
    public static func clear() {
        `default`.clear()
    }

    private let keychain: KeychainAccess.Keychain
    private let context: AppContext

    public init(context: AppContext = .mainApp) {
        self.keychain = .init(service: KeychainConstants.appKeychain)
            .accessibility(.afterFirstUnlockThisDeviceOnly)
        self.context = context
    }
}

extension AuthKeychain: AuthKeychainHandle {
    private var defaultStorageKey: String {
        storageKey(forContext: context) ?? StorageKey.authCredentials
    }

    private func storageKey(forContext context: AppContext) -> String? {
        StorageKey.contextKeys[context]
    }

    public func fetch(forContext context: AppContext?) -> AuthCredentials? {
        NSKeyedUnarchiver.setClass(AuthCredentials.self, forClassName: "ProtonVPN.AuthCredentials")
        var key = defaultStorageKey
        if let context = context, let contextKey = storageKey(forContext: context) {
            key = contextKey
        }

        do {
            if let data = try keychain.getData(key) {
                if let authCredentials = NSKeyedUnarchiver.unarchiveObject(with: data) as? AuthCredentials {
                    return authCredentials
                }
            }
        } catch let error {
            print("Keychain (auth) read error: \(error)")
            //log.error("Keychain (auth) read error: \(error)", category: .keychain)
        }

        return nil
    }

    public func store(_ credentials: AuthCredentials, forContext context: AppContext?) throws {
        NSKeyedArchiver.setClassName("ProtonVPN.AuthCredentials", for: AuthCredentials.self)

        var key = defaultStorageKey
        if let context = context, let contextKey = storageKey(forContext: context) {
            key = contextKey
        }

        do {
            try keychain.set(NSKeyedArchiver.archivedData(withRootObject: credentials), key: key)
        } catch let error {
            //log.error("Keychain (auth) write error: \(error). Will clean and retry.", category: .keychain, metadata: ["error": "\(error)"])
            do { // In case of error try to clean keychain and retry with storing data
                clear()
                try keychain.set(NSKeyedArchiver.archivedData(withRootObject: credentials), key: key)
            } catch let error2 {
                #if os(macOS)
                    log.error("Keychain (auth) write error: \(error2). Will lock keychain to try to recover from this error.", category: .keychain, metadata: ["error": "\(error2)"])
                    do { // Last chance. Locking/unlocking keychain sometimes helps.
                        SecKeychainLock(nil)
                        try keychain.set(NSKeyedArchiver.archivedData(withRootObject: credentials), key: key)
                    } catch let error3 {
                        log.error("Keychain (auth) write error. Giving up.", category: .keychain, metadata: ["error": "\(error3)"])
                        throw error3
                    }
                #else
                //log.error("Keychain (auth) write error. Giving up.", category: .keychain, metadata: ["error": "\(error2)"])
                    throw error2
                #endif
            }
        }
    }

    public func clear() {
        for storageKey in StorageKey.contextKeys.values {
            keychain[data: storageKey] = nil
        }
        DispatchQueue.main.async {
            NotificationCenter.default.post(name: Self.clearNotification, object: nil, userInfo: nil)
        }
    }
}

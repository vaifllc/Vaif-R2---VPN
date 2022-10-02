//
//  DoHVPN.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 9/30/22.
//

import Foundation


public protocol DoHVPNFactory {
    func makeDoHVPN() -> DoHVPN
}

public class DoHVPN: DoH, ServerConfig {
    public let liveURL: String = "https://api.protonvpn.ch"
    public let signupDomain: String = "protonmail.com"
    public let defaultPath: String = ""
    public var defaultHost: String {
        #if RELEASE
        if !Bundle.isTestflightBeta {
            return liveURL
        }
        #endif

        return customHost ?? liveURL
    }
    public var captchaHost: String {
        return defaultHost
    }
    public var apiHost: String {
        return customApiHost
    }
    public var statusHost: String {
        return "http://protonstatus.com"
    }

    public var humanVerificationV3Host: String {
        if defaultHost == liveURL {
            return verifyHost
        }

        // some test servers are hosted on a vpn subdomain that is not used for the verify host
        guard let url = URL(string: defaultHost.replacingOccurrences(of: "vpn.", with: "")), let host = url.host else {
            return ""
        }

        return "https://verify.\(host)"
    }

    public var alternativeRouting: Bool {
        didSet {
            settingsUpdated()
        }
    }

    private var appState: AppState {
        didSet {
            settingsUpdated()
        }
    }

    public var accountHost: String {
        if defaultHost == liveURL {
            return "https://account.proton.me"
        }

        // some test servers are hosted on a vpn subdomain that is not used for the account host
        guard let url = URL(string: defaultHost.replacingOccurrences(of: "vpn.", with: "")), let host = url.host else {
            return ""
        }

        return "https://account.\(host)"
    }

    private let customApiHost: String
    private let verifyHost: String
    private let customHost: String?

    public let atlasSecret: String?

    public var isAtlasRequest: Bool {
        return defaultHost != liveURL
    }

    public init(apiHost: String, verifyHost: String, alternativeRouting: Bool, customHost: String? = nil, atlasSecret: String? = nil, appState: AppState) {
        self.customApiHost = apiHost
        self.verifyHost = verifyHost
        self.customHost = customHost
        self.atlasSecret = atlasSecret
        self.alternativeRouting = alternativeRouting
        self.appState = appState
        super.init()

        //NotificationCenter.default.addObserver(self, selector: #selector(stateChanged), name: AppStateManagerNotification.stateChange, object: nil)

        status = alternativeRouting ? .on : .off
    }

    @objc private func stateChanged(notification: Notification) {
        guard let newState = notification.object as? AppState else {
            return
        }
        appState = newState
    }

    private func settingsUpdated() {
        if case .connected = appState {
            if status == .on {
                //log.debug("Disabling DoH while connected to VPN", category: .api)
            }
            status = .off
        } else {
            if status == .off, alternativeRouting {
               // log.debug("Re-enabling DoH while disconnected from VPN", category: .api)
            }
            status = alternativeRouting ? .on : .off
        }
    }
}

public extension DoHVPN {
    static let mock = DoHVPN(apiHost: "", verifyHost: "", alternativeRouting: false, appState: .disconnected)
}

//
//  AppDisplayState.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 9/27/22.
//

import Foundation

public enum AppDisplayState {
    case connected
    case connecting
    case loadingConnectionInfo
    case disconnecting
    case disconnected
}

extension AppState {
    func asDisplayState() -> AppDisplayState {
        switch self {
        case .connected:
            return .connected
        case .preparingConnection, .connecting:
            return .connecting
        case .disconnecting:
            return .disconnecting
        case .error, .disconnected, .aborted:
            return .disconnected
        }
    }
}


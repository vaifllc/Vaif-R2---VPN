//
//  AppState.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 9/27/22.
//

import Foundation

public enum AppState {
    
    case disconnected
    case preparingConnection
    case connecting(ServerDescriptor)
    case connected(ServerDescriptor)
    case disconnecting(ServerDescriptor)
    case aborted(userInitiated: Bool)
    case error(Error)
    
    public var description: String {
        let base = "AppState - "
        switch self {
        case .disconnected:
            return base + "Disconnected"
        case .preparingConnection:
            return base + "Preparing connection"
        case .connecting(let descriptor):
            return base + "Connecting to: \(descriptor.description)"
        case .connected(let descriptor):
            return base + "Connected to: \(descriptor.description)"
        case .disconnecting(let descriptor):
            return base + "Disconnecting from: \(descriptor.description)"
        case .aborted(let userInitiated):
            return base + "Aborted, user initiated: \(userInitiated)"
        case .error(let error):
            return base + "Error: \(error.localizedDescription)"
        }
    }
    
    public var isConnected: Bool {
        switch self {
        case .connected:
            return true
        default:
            return false
        }
    }
    
    public var isDisconnected: Bool {
        switch self {
        case .disconnected, .preparingConnection, .connecting, .aborted, .error:
            return true
        default:
            return false
        }
    }
    
    public var isStable: Bool {
        switch self {
        case .disconnected, .connected, .aborted, .error:
            return true
        default:
            return false
        }
    }
    
    public var isSafeToEnd: Bool {
        switch self {
        case .connecting, .connected, .disconnecting:
            return false
        default:
            return true
        }
    }
    
    public var descriptor: ServerDescriptor? {
        switch self {
        case .connecting(let desc), .connected(let desc), .disconnecting(let desc):
            return desc
        default:
            return nil
        }
    }

    public static let appStateKey: String = "AppStateKey"
}

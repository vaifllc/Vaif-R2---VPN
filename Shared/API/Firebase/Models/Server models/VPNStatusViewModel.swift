//
//  VPNStatusViewModel.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 12/27/22.
//

import UIKit
import NetworkExtension

struct VPNStatusViewModel {
    
    // MARK: - Properties -
    
    var status: NEVPNStatus
    
    var protectionStatusText: String {
        switch status {
        case .connecting, .reasserting:
            return "connecting"
        case .disconnecting:
            return "disconnecting"
        case .connected:
            return "connected"
        default:
            return "disconnected"
        }
    }
    
    var connectToServerText: String {
            switch status {
            case .connecting, .reasserting:
                return "Connecting to"
            case .connected:
                return "Traffic is routed via server"
            case .disconnecting:
            return "Disconnecting from"
            default:
//                if Application.shared.settings.selectedServer.fastest || Application.shared.settings.selectedServer.fastestServerLabelShouldBePresented {
//                    return "Fastest available server"
//                }
                return "Selected server"
            }
    }
    
    var connectToExitServerText: String {
        switch status {
        case .connected:
            return "Traffic is routed via exit server"
        default:
            return "Exit server is"
        }
    }
    
    var connectToggleIsOn: Bool {
        switch status {
        case .connected, .connecting, .reasserting:
            return true
        default:
            return false
        }
    }
    
    var popupStatusText: String {
        switch status {
        case .connecting, .reasserting:
            return "Connecting"
        case .disconnecting:
            return "Disconnecting"
        case .connected:
            return "Connected to"
        default:
            return "Your current location"
        }
    }
    
    // MARK: - Initialize -
    
    init(status: NEVPNStatus) {
        self.status = status
    }
    
}


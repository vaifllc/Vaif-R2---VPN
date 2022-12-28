//
//  NEVPNStatus+Ext.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 12/27/22.
//

import NetworkExtension

extension NEVPNStatus {
    
    func isDisconnected() -> Bool {
        return self == .disconnected || self == .invalid
    }
    
}

//
//  Logger+Categories.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 9/28/22.
//

import Foundation
import Logging

extension Logger {
    
    public enum Category: String {
        case connection = "conn"
        case connectionConnect = "conn.connect"
        case connectionDisconnect = "conn.disconnect"
        case localAgent = "local_agent"
        case ui
        case user
        case userCert = "user_cert"
        case userPlan = "user_plan"
        case api
        case net
        case `protocol`
        case app
        case appUpdate = "app.update"
        case os
        case settings
        case keychain = "secure_store"
        case iap = "in_app_purchase"
        // Custom ios (please add to confluence)
        case sysex // System Extension
        case review
        case core
    }

    public enum Event: String {
        case current
        case stateChange = "state_change"
        case error
        case trigger
        case scan
        case scanFailed = "scan_failed"
        case scanResult = "scan_result"
        case start
        case connected
        case serverSelected = "server_selected"
        case switchFailed = "switch_failed"
        case log
        case status
        case connect
        case disconnect
        case refresh
        case revoked
        case newCertificate = "new_cert"
        case refreshError = "refresh_error"
        case scheduleRefresh = "schedule_refresh"
        case change
        case maxSessionsReached = "max_sessions_reached"
        case request
        case response
        case networkUnavailable = "network_unavailable"
        case networkChanged = "network_changed"
        case processStart = "process_start"
        case crash
        case updateCheck = "update_check"
        case info
    }
}

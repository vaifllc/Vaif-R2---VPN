//
//  FeatureFlags.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 10/8/22.
//

import Foundation

public struct FeatureFlags: Codable {
    public let smartReconnect: Bool
    public let vpnAccelerator: Bool
    public let netShield: Bool
    public let streamingServicesLogos: Bool
    public let portForwarding: Bool
    public let moderateNAT: Bool
    public let pollNotificationAPI: Bool
    public let serverRefresh: Bool
    public let guestHoles: Bool
    public let safeMode: Bool
    @Default<Bool> public var promoCode: Bool

    public init(smartReconnect: Bool, vpnAccelerator: Bool, netShield: Bool, streamingServicesLogos: Bool, portForwarding: Bool, moderateNAT: Bool, pollNotificationAPI: Bool, serverRefresh: Bool, guestHoles: Bool, safeMode: Bool, promoCode: Bool) {
        self.smartReconnect = smartReconnect
        self.vpnAccelerator = vpnAccelerator
        self.netShield = netShield
        self.streamingServicesLogos = streamingServicesLogos
        self.portForwarding = portForwarding
        self.moderateNAT = moderateNAT
        self.pollNotificationAPI = pollNotificationAPI
        self.serverRefresh = serverRefresh
        self.guestHoles = guestHoles
        self.safeMode = safeMode
        self.promoCode = promoCode
    }

    public init() {
        self.init(smartReconnect: false, vpnAccelerator: false, netShield: true, streamingServicesLogos: false, portForwarding: false, moderateNAT: false, pollNotificationAPI: false, serverRefresh: false, guestHoles: false, safeMode: false, promoCode: false)
    }
}


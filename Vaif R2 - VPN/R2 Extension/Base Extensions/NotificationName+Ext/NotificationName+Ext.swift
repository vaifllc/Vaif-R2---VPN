//
//  NotificationName+Ext.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 12/27/22.
//

import Foundation

extension Notification.Name {
    
    public static let ServerSelected = Notification.Name("serverSelected")
    public static let Connect = Notification.Name("connect")
    public static let Disconnect = Notification.Name("disconnect")
    public static let TurnOffMultiHop = Notification.Name("turnOffMultiHop")
    public static let UpdateNetwork = Notification.Name("updateNetwork")
    public static let PingDidComplete = Notification.Name("pingDidComplete")
    public static let NetworkSaved = Notification.Name("networkSaved")
    public static let TermsOfServiceAgreed = Notification.Name("termsOfServiceAgreed")
    public static let SubscriptionDismissed = Notification.Name("subscriptionDismissed")
    public static let SubscriptionActivated = Notification.Name("subscriptionActivated")
    public static let ServiceAuthorized = Notification.Name("serviceAuthorized")
    public static let AuthenticationDismissed = Notification.Name("authenticationDismissed")
    public static let NewSession = Notification.Name("newSession")
    public static let ForceNewSession = Notification.Name("forceNewSession")
    public static let VPNConnectError = Notification.Name("vpnConnectError")
    public static let VPNConfigurationDisabled = Notification.Name("vpnConfigurationDisabled")
    public static let UpdateFloatingPanelLayout = Notification.Name("updateFloatingPanelLayout")
    public static let UpdateControlPanel = Notification.Name("updateControlPanel")
    public static let ProtocolSelected = Notification.Name("protocolSelected")
    public static let HideConnectionInfoPopup = Notification.Name("hideConnectionInfoPopup")
    public static let ShowConnectToServerPopup = Notification.Name("showConnectToServerPopup")
    public static let HideConnectToServerPopup = Notification.Name("hideConnectToServerPopup")
    public static let CenterMap = Notification.Name("centerMap")
    public static let UpdateGeoLocation = Notification.Name("updateGeoLocation")
    public static let UpdateResolvedDNS = Notification.Name("updateResolvedDNS")
    public static let UpdateResolvedDNSInsideVPN = Notification.Name("updateResolvedDNSInsideVPN")
    public static let ResolvedDNSError = Notification.Name("resolvedDNSError")
    public static let ServersListUpdated = Notification.Name("serversListUpdated")
    public static let AntiTrackerUpdated = Notification.Name("antiTrackerUpdatedUpdated")
    public static let CustomDNSUpdated = Notification.Name("customDNSUpdatedUpdated")
    public static let EvaluateReconnect = Notification.Name("evaluateReconnect")
    
}


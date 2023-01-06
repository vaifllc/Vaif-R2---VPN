//
//  NETunnelProviderProtocol+Ext.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 1/3/23.
//

import Foundation
import NetworkExtension
import Network
import TunnelKit
import WireGuardKit




extension NETunnelProviderProtocol {
    
    // MARK: OpenVPN
    
    static func makeOpenVPNProtocol(settings: ConnectionSettings, accessDetails: AccessDetails) -> NETunnelProviderProtocol {
        guard let host = getHost() else {
            return NETunnelProviderProtocol()
        }
        
        let username = accessDetails.username
        let socketType: SocketType = settings.protocolType() == "TCP" ? .tcp : .udp
        let credentials = OpenVPN.Credentials(username, KeyChain.vpnPassword ?? "")
        let staticKey = OpenVPN.StaticKey.init(file: OpenVPNConf.tlsAuth, direction: OpenVPN.StaticKey.Direction.client)
        let port = UInt16(getPort(settings: settings))
        
        var sessionBuilder = OpenVPN.ConfigurationBuilder()
        sessionBuilder.ca = OpenVPN.CryptoContainer(pem: OpenVPNConf.caCert)
        sessionBuilder.cipher = .aes256cbc
        sessionBuilder.compressionFraming = .disabled
        sessionBuilder.endpointProtocols = [EndpointProtocol(socketType, port)]
        sessionBuilder.hostname = host.host
        sessionBuilder.tlsWrap = OpenVPN.TLSWrap.init(strategy: .auth, key: staticKey!)
        
        if let dnsServers = openVPNdnsServers(), !dnsServers.isEmpty, dnsServers != [""] {
            sessionBuilder.dnsServers = dnsServers
            
            switch DNSProtocolType.preferred() {
            case .doh:
                sessionBuilder.dnsProtocol = .https
                sessionBuilder.dnsHTTPSURL = URL.init(string: DNSProtocolType.getServerURL(address: UserDefaults.shared.customDNS))
            case .dot:
                sessionBuilder.dnsProtocol = .tls
                sessionBuilder.dnsTLSServerName = DNSProtocolType.getServerName(address: UserDefaults.shared.customDNS)
            default:
                sessionBuilder.dnsProtocol = .plain
            }
        }
        
        var builder = OpenVPNTunnelProvider.ConfigurationBuilder(sessionConfiguration: sessionBuilder.build())
        builder.shouldDebug = true
        builder.debugLogFormat = "$Dyyyy-MM-dd HH:mm:ss$d $L $M"
        builder.masksPrivateData = true
        
        let configuration = builder.build()
        let keychain = Keychain(group: R2Config.appGroup)
        try? keychain.set(password: credentials.password, for: credentials.username, context: R2Config.openvpnTunnelProvider)
        let proto = try! configuration.generatedTunnelProtocol(
            withBundleIdentifier: R2Config.openvpnTunnelProvider,
            appGroup: R2Config.appGroup,
            context: R2Config.openvpnTunnelProvider,
            username: credentials.username
        )
        proto.disconnectOnSleep = !UserDefaults.shared.keepAlive
        if #available(iOS 15.1, *) {
            proto.includeAllNetworks = UserDefaults.shared.killSwitch
        }
        
        return proto
    }
    
    static func openVPNdnsServers() -> [String]? {
        if UserDefaults.shared.isAntiTracker {
            if UserDefaults.shared.isAntiTrackerHardcore {
                if !UserDefaults.shared.antiTrackerHardcoreDNS.isEmpty {
                    return [UserDefaults.shared.antiTrackerHardcoreDNS]
                }
            } else {
                if !UserDefaults.shared.antiTrackerDNS.isEmpty {
                    return [UserDefaults.shared.antiTrackerDNS]
                }
            }
        } else if UserDefaults.shared.isCustomDNS && !UserDefaults.shared.customDNS.isEmpty {
            return UserDefaults.shared.resolvedDNSInsideVPN
        }
        
        return nil
    }
    
    // MARK: WireGuard
    
    static func makeWireGuardProtocol(settings: ConnectionSettings) -> NETunnelProviderProtocol {
        guard let host = getHost() else {
            return NETunnelProviderProtocol()
        }
        
        var addresses = KeyChain.wgIpAddress
        var publicKey = host.publicKey
        let port = getPort(settings: settings)
        var endpoint = Peer.endpoint(host: host.host, port: port)
        
        if UserDefaults.shared.isMultiHop, Application.shared.serviceStatus.isEnabled(capability: .multihop), let exitHost = getExitHost() {
            publicKey = exitHost.publicKey
            endpoint = Peer.endpoint(host: host.host, port: port)
        }
        
        if let ipv6 = host.ipv6, UserDefaults.shared.isIPv6 {
            addresses = Interface.getAddresses(ipv4: KeyChain.wgIpAddress, ipv6: ipv6.localIP)
            KeyChain.wgIpAddresses = addresses
            KeyChain.wgIpv6Host = ipv6.localIP
        }
        
        let peer = Peer(
            publicKey: publicKey,
            allowedIPs: R2Config.wgPeerAllowedIPs,
            endpoint: endpoint,
            persistentKeepalive: R2Config.wgPeerPersistentKeepalive
        )
        let interface = Interface(
            addresses: addresses,
            listenPort: R2Config.wgInterfaceListenPort,
            privateKey: KeyChain.wgPrivateKey,
            dns: host.localIPAddress()
        )
        let tunnel = Tunnel(
            tunnelIdentifier: UIDevice.uuidString(),
            title: R2Config.wireguardTunnelTitle,
            interface: interface,
            peers: [peer]
        )
        
        let configuration = NETunnelProviderProtocol()
        configuration.providerBundleIdentifier = R2Config.wireguardTunnelProvider
        configuration.serverAddress = peer.endpoint
        configuration.providerConfiguration = tunnel.generateProviderConfiguration()
        configuration.disconnectOnSleep = !UserDefaults.shared.keepAlive
        if #available(iOS 15.1, *) {
            configuration.includeAllNetworks = UserDefaults.shared.killSwitch
        }
        
        return configuration
    }
    
    // MARK: Methods
    
    private static func getHost() -> Host? {
        if let selectedHost = Application.shared.settings.selectedHost {
            return selectedHost
        }
        
        if let randomHost = Application.shared.settings.selectedServer.hosts.randomElement() {
            return randomHost
        }
        
        return nil
    }
    
    private static func getExitHost() -> Host? {
        if let selectedHost = Application.shared.settings.selectedExitHost {
            return selectedHost
        }
        
        if let randomHost = Application.shared.settings.selectedExitServer.hosts.randomElement() {
            return randomHost
        }
        
        return nil
    }
    
    private static func getPort(settings: ConnectionSettings) -> Int {
        if UserDefaults.shared.isMultiHop, Application.shared.serviceStatus.isEnabled(capability: .multihop), let exitHost = getExitHost() {
            return exitHost.multihopPort
        }
        
        return settings.port()
    }
    
}


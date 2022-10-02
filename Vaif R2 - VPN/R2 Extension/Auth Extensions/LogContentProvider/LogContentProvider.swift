//
//  LogContentProvider.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 9/30/22.
//

import Foundation

public protocol LogContentProviderFactory {
    func makeLogContentProvider() -> LogContentProvider
}

public protocol LogContentProvider {
    func getLogData(for source: LogSource) -> LogContent
}

#if os(iOS)
/// Create and return a proper LogData implementation for a given log source
public class IOSLogContentProvider: LogContentProvider {

    private let folder: URL
    private let appGroup: String
    //private let wireguardProtocolFactory: WireguardProtocolFactory

    public init(appLogsFolder folder: URL, appGroup: String/* wireguardProtocolFactory: WireguardProtocolFactory*/) {
        self.folder = folder
        self.appGroup = appGroup
        //self.wireguardProtocolFactory = wireguardProtocolFactory
    }

    public func getLogData(for source: LogSource) -> LogContent {
        switch source {
        case .app:
            return AppLogContent(folder: folder)

        case .osLog:
            guard #available(iOS 15, *) else {
                return EmptyLogContent()
            }
            return OSLogContent()

        case .openvpn:
            let folder = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: appGroup) ?? FileManager.default.temporaryDirectory
            return FileLogContent(file: folder.appendingPathComponent(CoreAppConstants.LogFiles.openVpn))

        case .wireguard:
            let folder = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: appGroup) ?? FileManager.default.temporaryDirectory
//            return WGiOSLogContent(fileLogContent: FileLogContent(file: folder.appendingPathComponent(CoreAppConstants.LogFiles.wireGuard)), wireguardProtocolFactory: wireguardProtocolFactory)
            return OSLogContent()
        }
    }

}

#elseif os(macOS)

/// Create and return a proper LogData implementation for a given log source
public class MacOSLogContentProvider: LogContentProvider {

    private let folder: URL
    private let wireguardProtocolFactory: WireguardProtocolFactory
    private let openVpnProtocolFactory: OpenVpnProtocolFactory

    public init(appLogsFolder folder: URL, wireguardProtocolFactory: WireguardProtocolFactory, openVpnProtocolFactory: OpenVpnProtocolFactory) {
        self.folder = folder
        self.wireguardProtocolFactory = wireguardProtocolFactory
        self.openVpnProtocolFactory = openVpnProtocolFactory
    }

    public func getLogData(for source: LogSource) -> LogContent {
        switch source {
        case .app:
            return AppLogContent(folder: folder)

        case .osLog:
            guard #available(macOS 12, *) else {
                return EmptyLogContent()
            }
            return OSLogContent()

        case .openvpn:
            return NELogContent(protocolFactory: openVpnProtocolFactory)

        case .wireguard:
            return NELogContent(protocolFactory: wireguardProtocolFactory)
            
        }
    }

}
#endif


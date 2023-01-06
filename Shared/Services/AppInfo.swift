//
//  AppInfo.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 9/28/22.
//

import Foundation
#if os(iOS)
import UIKit
#endif

public enum AppContext: String {
    case mainApp
    case siriIntentHandler
    case wireGuardExtension

    fileprivate var clientIdKey: String {
        switch self {
        case .mainApp, .siriIntentHandler:
            return "Id"
        case .wireGuardExtension:
            return "WireGuardId"
        }
    }
}

public protocol AppInfoFactory {
    func makeAppInfo(context: AppContext) -> AppInfo
}

extension AppInfoFactory {
    public func makeAppInfo() -> AppInfo {
        makeAppInfo(context: .mainApp)
    }
}

public protocol AppInfo {
    var context: AppContext { get }
    var bundleInfoDictionary: [String: Any] { get }
    var clientInfoDictionary: [String: Any] { get }

    var processName: String { get }
    var modelName: String? { get }
    var osVersion: OperatingSystemVersion { get }
}

extension AppInfo {
    public var appVersion: String {
        clientId + "@" + bundleShortVersion
    }

    public var clientId: String {
        return clientInfoDictionary[context.clientIdKey] as? String ?? ""
    }

    public var bundleShortVersion: String {
        return Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
    }

    public var bundleVersion: String {
        return Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? ""
    }

    private var platformName: String {
        #if os(iOS)
            return "iOS"
        #elseif os(macOS)
            return "Mac OS X"
        #elseif os(watchOS)
            return "watchOS"
        #elseif os(tvOS)
            return "tvOS"
        #else
            return "unknown"
        #endif
    }

    private var osVersionString: String {
        "\(platformName) \(osVersion.majorVersion).\(osVersion.minorVersion).\(osVersion.patchVersion)"
    }

    public var userAgent: String {
        var modelString: String = ""
        if let modelName = modelName {
            modelString = "; \(modelName)"
        }

        return "\(processName)/\(bundleShortVersion) (\(osVersionString)\(modelString))"
    }
}

public class AppInfoImplementation: AppInfo {
    public let bundleInfoDictionary: [String: Any]
    public let clientInfoDictionary: [String: Any]
    public let processName: String
    public let modelName: String?
    public let osVersion: OperatingSystemVersion
    public let context: AppContext

    public init(context: AppContext, bundle: Bundle = Bundle.main, processInfo: ProcessInfo = ProcessInfo(), modelName: String? = nil) {
        self.context = context
        processName = processInfo.processName
        osVersion = processInfo.operatingSystemVersion

        if let modelName = modelName {
            self.modelName = modelName
        } else {
            #if os(iOS)
            self.modelName = UIDevice.current.modelName
            #else
            self.modelName = Host.current().localizedName ?? nil
            #endif
        }

        guard let file = bundle.path(forResource: "Client", ofType: "plist"),
              let clientDict = NSDictionary(contentsOfFile: file) as? [String: Any],
              let infoDict = bundle.infoDictionary else {
            clientInfoDictionary = [:]
            bundleInfoDictionary = [:]
            return
        }

        clientInfoDictionary = clientDict
        bundleInfoDictionary = infoDict
    }
}

//
//  FeatureCellViewModel.swift
//  VaifR2
//
//  Created by VAIF on 1/7/23.
//

import Foundation
#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#endif

public protocol FeatureCellViewModel {
    var icon: Image { get }
    var title: String { get }
    var description: String { get }
    var urlContact: String { get }
    var displayLoads: Bool { get }
}

extension FeatureCellViewModel {
    public var displayLoads: Bool {
        return false
    }
}

// MARK: - Features

public struct SmartRoutingFeature: FeatureCellViewModel {
    public let icon: Image = IconProvider.globe
    public let title: String = LocalizedString.smartRoutingTitle
    public let description: String = LocalizedString.featureSmartRoutingDescription
    public let urlContact: String = CoreAppConstants.ProtonVpnLinks.learnMoreSmartRouting
    public init () { }
}

public struct StreamingFeature: FeatureCellViewModel {
    public let icon: Image = IconProvider.play
    public let title: String = LocalizedString.streamingTitle
    public let description: String = LocalizedString.featureStreamingDescription
    public let urlContact: String = CoreAppConstants.ProtonVpnLinks.learnMoreStreaming
    public init () { }
}

public struct P2PFeature: FeatureCellViewModel {
    public let icon: Image = IconProvider.arrowsSwitch
    public let title: String = LocalizedString.p2pTitle
    public let description: String = LocalizedString.featureP2pDescription
    public let urlContact: String = CoreAppConstants.ProtonVpnLinks.learnMoreP2p
    public init () { }
}

public struct TorFeature: FeatureCellViewModel {
    public let icon: Image = IconProvider.brandTor
    public let title: String = LocalizedString.featureTor
    public let description: String = LocalizedString.featureTorDescription
    public let urlContact: String = CoreAppConstants.ProtonVpnLinks.learnMoreTor
    public init () { }
}

public struct LoadPerformanceFeature: FeatureCellViewModel {
    public let icon: Image = IconProvider.servers
    public let title: String = LocalizedString.serverLoadTitle
    public let description: String = LocalizedString.performanceLoadDescription
    public let urlContact: String = CoreAppConstants.ProtonVpnLinks.learnMoreLoads
    public let displayLoads: Bool = true
    public init () { }
}


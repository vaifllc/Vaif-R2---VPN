//
//  TroubleshootItem.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 9/27/22.
//

import Foundation

public protocol TroubleshootItem {
    var title: String { get }
    var description: NSAttributedString { get }
}

public protocol ActionableTroubleshootItem: TroubleshootItem {
    var isOn: Bool { get }

    func set(isOn: Bool)
}

public struct BasicTroubleshootItem: TroubleshootItem {
    public let title: String
    public let description: NSAttributedString
}

public final class AlternateRoutingTroubleshootItem: ActionableTroubleshootItem {
    public let title: String
    public let description: NSAttributedString
    public var isOn: Bool

    private let propertiesManager: PropertiesManagerProtocol

    init(propertiesManager: PropertiesManagerProtocol) {
        self.propertiesManager = propertiesManager

        title = LocalizedString.troubleshootItemAltTitle
        description = NSMutableAttributedString(string: LocalizedString.troubleshootItemAltDescription).add(link: LocalizedString.troubleshootItemAltLink1, withUrl: CoreAppConstants.ProtonVpnLinks.alternativeRouting)
        isOn = propertiesManager.alternativeRouting
    }

    public func set(isOn: Bool) {
        self.isOn = isOn
        propertiesManager.alternativeRouting = isOn
    }
}


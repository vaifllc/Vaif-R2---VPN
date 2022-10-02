//
//  TroubleshootViewModel.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 9/27/22.
//

import Foundation

public protocol TroubleshootViewModelFactory {
    func makeTroubleshootViewModel() -> TroubleshootViewModel
}

public final class TroubleshootViewModel {

    // Data
    public let items: [TroubleshootItem]

    // MARK: - Callbacks

    public var cancelled: (() -> Void)?

    public func cancel() {
        cancelled?()
    }

    // MARK: - Data

    private let supportEmail = "support@protonvpn.com"
    private let urlTor = "https://www.torproject.org"
    private let urlProtonStatus = "http://protonstatus.com"
    private let urlSupportForm = "https://protonvpn.com/support-form"
    private let urlTwitter = "https://twitter.com/ProtonVPN"

    public init(propertiesManager: PropertiesManagerProtocol) {
        items = [
            // Alternative routing
            AlternateRoutingTroubleshootItem(propertiesManager: propertiesManager),

            // No internet
            BasicTroubleshootItem(title: LocalizedString.troubleshootItemNointernetTitle,
                                          description: NSMutableAttributedString(string: LocalizedString.troubleshootItemNointernetDescription)),

            // ISP
            BasicTroubleshootItem(title: LocalizedString.troubleshootItemIspTitle,
                                          description: NSMutableAttributedString(string: LocalizedString.troubleshootItemIspDescription)
                                            .add(link: LocalizedString.troubleshootItemIspLink1, withUrl: urlTor)),

            // ISP
            BasicTroubleshootItem(title: LocalizedString.troubleshootItemGovTitle,
                                          description: NSMutableAttributedString(string: LocalizedString.troubleshootItemGovDescription)
                                            .add(link: LocalizedString.troubleshootItemGovLink1, withUrl: urlTor)),

            // Antivirus
            BasicTroubleshootItem(title: LocalizedString.troubleshootItemAntivirusTitle,
                                          description: NSMutableAttributedString(string: LocalizedString.troubleshootItemAntivirusDescription)),

            // Proxy / Firewall
            BasicTroubleshootItem(title: LocalizedString.troubleshootItemProxyTitle,
                                          description: NSMutableAttributedString(string: LocalizedString.troubleshootItemProxyDescription)),

            // Proton status
            BasicTroubleshootItem(title: LocalizedString.troubleshootItemProtonTitle,
                                          description: NSMutableAttributedString(string: LocalizedString.troubleshootItemProtonDescription)
                                            .add(link: LocalizedString.troubleshootItemProtonLink1, withUrl: urlProtonStatus)),

            // Contact / Other
            BasicTroubleshootItem(title: LocalizedString.troubleshootItemOtherTitle,
                                          description: NSMutableAttributedString(string: LocalizedString.troubleshootItemOtherDescription(supportEmail))
                                            .add(links: [
                                                (LocalizedString.troubleshootItemOtherLink1, urlSupportForm),
                                                (LocalizedString.troubleshootItemOtherLink2, String(format: "mailto:%@", supportEmail)),
                                                (LocalizedString.troubleshootItemOtherLink3, urlTwitter)
                                            ])),
        ]
    }

}


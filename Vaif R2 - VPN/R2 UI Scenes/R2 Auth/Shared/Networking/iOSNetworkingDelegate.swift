//
//  iOSNetworkingDelegate.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 9/30/22.
//

import Foundation


final class iOSNetworkingDelegate: NetworkingDelegate {
    //private let forceUpgradeService: ForceUpgradeDelegate
    private var humanVerify: HumanVerifyDelegate?
    private let alertingService: CoreAlertService

    init(alertingService: CoreAlertService) {
        //self.forceUpgradeService = ForceUpgradeHelper(config: .mobile(URL(string: URLConstants.appStoreUrl)!))
        self.alertingService = alertingService
    }

    func set(apiService: APIService) {
        humanVerify = HumanCheckHelper(apiService: apiService, supportURL: getSupportURL(), clientApp: ClientApp.vpn, versionToBeUsed: version)
    }

    func onLogout() {
        alertingService.push(alert: RefreshTokenExpiredAlert())
    }
}

extension iOSNetworkingDelegate {
    func onHumanVerify(parameters: HumanVerifyParameters, currentURL: URL?, error: NSError, completion: (@escaping (HumanVerifyFinishReason) -> Void)) {
        humanVerify?.onHumanVerify(parameters: parameters, currentURL: currentURL, error: error, completion: completion)
    }

    func getSupportURL() -> URL {
        return URL(string: CoreAppConstants.ProtonVpnLinks.support)!
    }
}

extension iOSNetworkingDelegate {
    func onForceUpgrade(message: String) {
        //forceUpgradeService.onForceUpgrade(message: message)
    }
}

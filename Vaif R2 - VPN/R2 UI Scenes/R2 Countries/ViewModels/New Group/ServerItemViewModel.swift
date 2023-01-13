//
//  ServerItemViewModel.swift
//  VaifR2
//
//  Created by VAIF on 1/7/23.
//

import UIKit
import Search
//import AlamofireImage

class ServerItemViewModel: ServerItemViewModelCore {

    private let alertService: AlertService
//    private let connectionStatusService: ConnectionStatusService
    private var userTier2: Int = CoreAppConstants.VpnTiers.plus
//    private let planService: PlanService

//    var partnersIconsReceipts: [RequestReceipt] = []
    
    var isConnected: Bool {
//        if vpnGateway.connection == .connected,
//           let activeServer = appStateManager.activeConnection()?.server,
//           activeServer.id == serverModel.id {
//            return true
//        }

        return false
    }
    
    var isConnecting: Bool {
//        if let activeConnection = vpnGateway.lastConnectionRequest,
//           vpnGateway.connection == .connecting,
//           case ConnectionRequestType.country(_, let countryRequestType) = activeConnection.connectionType,
//           case CountryConnectionRequestType.server(let activeServer) = countryRequestType,
//           activeServer == serverModel {
//            return true
//        }
        return false
    }
    
    var viaCountry: (name: String, code: String)? {
        return nil
    }
    
    
    
    var connectedUiState: Bool {
        return isConnected || isConnecting
    }
    
    fileprivate var canConnect: Bool {
        return !isUsersTierTooLow && !underMaintenance
    }

    var connectionChanged: (() -> Void)?
    var countryConnectionChanged: Notification.Name?
    
    // MARK: First line in the TableCell
    
    var description: String { return serverModel.ovpnName }
    
    var city: String {
        return serverModel.city
    }
    
    var loadColor: UIColor {
//        if serverModel.load > 90 {
//            return .notificationErrorColor()
//        } else if serverModel.load > 75 {
//            return .notificationWarningColor()
//        } else {
//            return .notificationOKColor()
//        }
        return .notificationOKColor()
    }
    
    var connectIcon: UIImage? {
        if isUsersTierTooLow {
            return IconProvider.lock
        } else if underMaintenance {
            return IconProvider.wrench
        } else {
            return IconProvider.powerOff
        }
    }
    
    var textInPlaceOfConnectIcon: String? {
        return isUsersTierTooLow ? LocalizedString.upgrade : nil
    }
    
    init(serverModel: ServerModel,
         //vpnGateway: VpnGatewayProtocol,
         appStateManager: AppStateManager,
         alertService: AlertService,
//         connectionStatusService: ConnectionStatusService,
         propertiesManager: PropertiesManagerProtocol/*,
         planService: PlanService*/) {

        self.alertService = alertService
//        self.connectionStatusService = connectionStatusService
        //self.planService = planService

        super.init(serverModel: serverModel,
                   //vpnGateway: vpnGateway,
                   appStateManager: appStateManager,
                   propertiesManager: propertiesManager)
        if canConnect {
            startObserving()
        }
    }
    
    func connectAction() {
        log.debug("Connect requested by clicking on Server item", category: .connectionConnect, event: .trigger)
        
        if underMaintenance {
            log.debug("Connect rejected because server is in maintenance", category: .connectionConnect, event: .trigger)
            alertService.push(alert: MaintenanceAlert(forSpecificCountry: nil))
        } else if isUsersTierTooLow {
            log.debug("Connect rejected because user plan is too low", category: .connectionConnect, event: .trigger)
            //planService.presentPlanSelection()
        } else if isConnected {
            log.debug("VPN is connected already. Will be disconnected.", category: .connectionDisconnect, event: .trigger)
            //vpnGateway.disconnect()
        } else if isConnecting {
            log.debug("VPN is connecting. Will stop connecting.", category: .connectionDisconnect, event: .trigger)
            //vpnGateway.stopConnecting(userInitiated: true)
        } else {
           // log.debug("Will connect to \(serverModel.logDescription)", category: .connectionConnect, event: .trigger)
            log.debug("Will connect to", category: .connectionDisconnect, event: .trigger)
            //vpnGateway.connectTo(server: serverModel)
            //connectionStatusService.presentStatusViewController()
        }
    }
    
    // MARK: - Private functions
    fileprivate func startObserving() {
//        NotificationCenter.default.addObserver(self, selector: #selector(stateChanged),
//                                               name: VpnGateway.connectionChanged, object: nil)
    }
    
    @objc fileprivate func stateChanged() {
        if let connectionChanged = connectionChanged {
            DispatchQueue.main.async {
                connectionChanged()
            }
        }
    }
}

// MARK: - SecureCoreServerItemViewModel subclass
class SecureCoreServerItemViewModel: ServerItemViewModel {
        
    override var viaCountry: (name: String, code: String)? {
      //  return isSecureCoreEnabled ? (serverModel.entryCountry, serverModel.entryCountryCode) : nil
        return nil
    }

    override fileprivate func startObserving() {
//        NotificationCenter.default.addObserver(self, selector: #selector(stateChanged),
//                                               name: VpnGateway.connectionChanged, object: nil)
    }
}

// MARK: - Search

extension ServerItemViewModel: ServerViewModel {
    var isPartnerServer: Bool {
        return false
    }
    
    var isTorAvailable: Bool {
        return false
    }
    
    var isP2PAvailable: Bool {
        return false
    }
    
    func partnersIcon(completion: @escaping (UIImage?) -> Void) { }
    

    
    var isSmartAvailable: Bool {
        return false
    }
    
    var torAvailable: Bool {
        return false
    }
    
    var p2pAvailable: Bool {
        return false
    }
    
    var streamingAvailable: Bool {
        return false
    }
    
    var loadValue: String {
        "56%"
    }
    
    func updateTier() {
        userTier2 = CoreAppConstants.VpnTiers.free
    }
    

    func cancelPartnersIconRequests() {
//        partnersIconsReceipts.forEach {
//            $0.request.cancel()
//        }
    }

//    func partnersIcon(completion: @escaping (UIImage?) -> Void) {
//        let iconURLs: [URLRequest] = partners.compactMap {
//            guard let iconURL = $0.iconURL else { return nil }
//            return URLRequest(url: iconURL)
//        }
//        guard !iconURLs.isEmpty else { return }
//
//        partnersIconsReceipts = AlamofireImage.ImageDownloader.default.download(iconURLs, completion: { response in
//            completion(response.value)
//        })
//    }

    var connectButtonColor: UIColor {
        if underMaintenance {
            return isUsersTierTooLow ? UIColor.weakInteractionColor() : .clear
        }
        return connectedUiState ? UIColor.interactionNorm() : UIColor.weakInteractionColor()
    }

    var entryCountryName: String? {
        return viaCountry?.name
    }

    var entryCountryFlag: UIImage? {
        guard let code = viaCountry?.code else {
            return nil
        }

        return UIImage.flag(countryCode: code)
    }

    var countryName: String {
        return LocalizationUtility.default.countryName(forCode: serverModel.countryCode) ?? ""
    }

    var countryFlag: UIImage? {
        return UIImage.flag(countryCode: serverModel.countryCode)
    }

    var translatedCity: String? {
        return serverModel.city
    }

    var textColor: UIColor {
        return UIColor.normalTextColor()
    }
}

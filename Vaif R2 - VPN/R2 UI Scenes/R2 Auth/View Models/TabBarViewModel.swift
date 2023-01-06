//
//  TabBarViewModel.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 9/26/22.
//

import Foundation
import FirebaseAuth

protocol TabBarViewModelModelDelegate: AnyObject {
    func removeLoginBox()
}

protocol TabBarViewModelDelegate: AnyObject {
    func connectedQuickConnect()
    func connectingQuickConnect()
    func disconnectedQuickConnect()
}

class TabBarViewModel {
    // MARK: Properties
    let navigationService: NavigationService
//    let sessionManager: AppSessionManager
//    let appStateManager: AppStateManager
//    let vpnGateway: VpnGatewayProtocol?
    //let connectionStatusService: ConnectionStatusService
    weak var delegate: TabBarViewModelDelegate?
    
    var showLoginAnimated: Bool {
        return true
    }
    
    // MARK: Initializers
    init(navigationService: NavigationService
         /*sessionManager: AppSessionManager,
         appStateManager: AppStateManager,
         vpnGateway: VpnGatewayProtocol?*/) {
        self.navigationService = navigationService
        //self.sessionManager = sessionManager
        //self.appStateManager = appStateManager
       // self.vpnGateway = vpnGateway
        //self.connectionStatusService = navigationService
        
        startObserving()
    }
    
    // MARK: Functions
    
    func quickConnectTapped() {
//        log.debug("Connect requested by clicking on Quick connect", category: .connectionConnect, event: .trigger)
//
//        guard let vpnGateway = vpnGateway else {
//            log.debug("Will not connect because user is not logged in", category: .connectionConnect, event: .trigger)
//            navigationService.presentWelcome(initialError: nil)
//            return
//        }
//
//        if vpnGateway.connection == .disconnected || vpnGateway.connection == .disconnecting {
//            vpnGateway.quickConnect()
//            connectionStatusService.presentStatusViewController()
//
//        } else if vpnGateway.connection == .connecting {
//            log.debug("VPN is connecting. Will stop connecting.", category: .connectionDisconnect, event: .trigger)
//            vpnGateway.stopConnecting(userInitiated: true)
//
//        } else {
//            log.debug("VPN is connected already. Will be disconnected.", category: .connectionDisconnect, event: .trigger)
//            vpnGateway.disconnect()
//        }
    }
    
    func settingShouldBeSelected() -> Bool {
        return false
        if Auth.auth().currentUser?.uid != nil {
            return true
        } else {
            navigationService.presentWelcome(initialError: nil)
            return false
        }
    }
    
    @objc func stateChanged() {
//        DispatchQueue.main.async { [weak self] in
//            switch self?.appStateManager.displayState {
//            case .connected:
//                self?.delegate?.connectedQuickConnect()
//            case .loadingConnectionInfo, .connecting:
//                self?.delegate?.connectingQuickConnect()
//            default:
//                self?.delegate?.disconnectedQuickConnect()
//            }
//        }
    }
    
    // MARK: - Private
    private func startObserving() {
//        NotificationCenter.default.addObserver(self, selector: #selector(stateChanged),
//                                               name: AppStateManagerNotification.displayStateChange, object: nil)
    }
}


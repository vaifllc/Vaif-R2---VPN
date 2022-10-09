//
//  MaintenanceManagerHelper.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 10/8/22.
//

import Foundation
import Logging

public protocol MaintenanceManagerHelperFactory {
    func makeMaintenanceManagerHelper() -> MaintenanceManagerHelper
}

/// Object for watching properties manager changes and starting/stopping MaintenannceManager
public class MaintenanceManagerHelper {
    
    public typealias Factory = MaintenanceManagerFactory & PropertiesManagerFactory & CoreAlertServiceFactory //& VpnGatewayFactory
    private let factory: Factory
    
    private lazy var maintenanceManager: MaintenanceManagerProtocol = factory.makeMaintenanceManager()
    private lazy var propertiesManager: PropertiesManagerProtocol = factory.makePropertiesManager()
    private lazy var alertService: CoreAlertService = factory.makeCoreAlertService()
//    private lazy var vpnGateWay: VpnGatewayProtocol = factory.makeVpnGateway()
    
    public init(factory: Factory) {
        self.factory = factory
        NotificationCenter.default.addObserver(self, selector: #selector(featureFlagsChanged), name: PropertiesManager.featureFlagsNotification, object: nil)
    }
    
    @objc func featureFlagsChanged() {
        startMaintenanceManager()
    }
    
    public func startMaintenanceManager() {
        guard propertiesManager.featureFlags.serverRefresh else {
            maintenanceManager.stopObserving()
            return // Feature is disabled
        }
        
        let time = TimeInterval(propertiesManager.maintenanceServerRefreshIntereval * 60)
        maintenanceManager.observeCurrentServerState(every: time, repeats: true, completion: { [weak self] isMaintenance in
            guard isMaintenance else {
                return
            }

            log.info("The currently connected server will be going to maintenance soon, reconnecting", category: .connectionConnect)
            self?.alertService.push(alert: VpnServerOnMaintenanceAlert())
          //  self?.vpnGateWay.quickConnect()
        }, failure: { error in
            log.error("Checking for server maintenance failed", category: .app, metadata: ["error": "\(error)"])
        })
    }
    
}


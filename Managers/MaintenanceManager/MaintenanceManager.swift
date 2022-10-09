//
//  MaintenanceManager.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 10/8/22.
//

import Foundation

public protocol MaintenanceManagerFactory {
    func makeMaintenanceManager() -> MaintenanceManagerProtocol
}

public typealias BoolCallback = GenericCallback<Bool>

public protocol MaintenanceManagerProtocol {
    func observeCurrentServerState(every timeInterval: TimeInterval, repeats: Bool, completion: BoolCallback?, failure: ErrorCallback?)
    func stopObserving()
}

public class MaintenanceManager: MaintenanceManagerProtocol {
    
    public typealias Factory = //VpnApiServiceFactory
     AppStateManagerFactory
   // & VpnGatewayFactory
    & CoreAlertServiceFactory
    //& ServerStorageFactory
    
    private let factory: Factory
    
  //  private lazy var vpnApiService: VpnApiService = self.factory.makeVpnApiService()
    private lazy var appStateManager: AppStateManager = self.factory.makeAppStateManager()
   // private lazy var vpnGateWay: VpnGatewayProtocol = self.factory.makeVpnGateway()
    private lazy var alertService: CoreAlertService = self.factory.makeCoreAlertService()
   // private lazy var serverStorage: ServerStorage = self.factory.makeServerStorage()
    
    private var timer: Timer?
    
    public init( factory: Factory) {
        self.factory = factory
    }
    
    // MARK: - MaintenanceManagerProtocol
    
    public func observeCurrentServerState(every timeInterval: TimeInterval, repeats: Bool, completion: BoolCallback?, failure: ErrorCallback?) {
        if !repeats || timeInterval <= 0 {
            self.checkServer(completion, failure: failure)
            return
        }
        
        if timer != nil {
            guard timer?.timeInterval != timeInterval else {
                return // Only restart timer if time interval has changed
            }
            timer?.invalidate()
            timer = nil
        }
        
        timer = Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: true) { timer in
            self.checkServer(completion, failure: failure)
        }
    }
    
    public func stopObserving() {
        if timer != nil {
            timer?.invalidate()
        }
        timer = nil
    }
    
    private func checkServer(_ completion: BoolCallback?, failure: ErrorCallback?) {
//        guard let activeConnection = appStateManager.activeConnection() else {
//           // log.info("No active connection", category: .app)
//            completion?(false)
//            return
//        }
//
        switch appStateManager.state {
        case .connected, .connecting:
            break
        default:
          //  log.info("VPN Not connected", category: .app)
            completion?(false)
            return
        }
        
       // let serverID = activeConnection.serverIp.id

    }
}


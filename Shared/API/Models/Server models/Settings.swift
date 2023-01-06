//
//  Settings.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 1/2/23.
//

import Foundation
import NetworkExtension

class R1Settings {
    
    // MARK: - Properties -
    
    var selectedServer: ServerModel {
        didSet {
            UserDefaults.standard.set(selectedServer.gateway, forKey: UserDefaults.Key.selectedServerGateway)
            UserDefaults.standard.set(selectedServer.city, forKey: UserDefaults.Key.selectedServerCity)
            UserDefaults.standard.set(selectedServer.fastest, forKey: UserDefaults.Key.selectedServerFastest)
            UserDefaults.standard.set(selectedServer.random, forKey: UserDefaults.Key.selectedServerRandom)
        }
    }
    
    var selectedExitServer: ServerModel {
        didSet {
            UserDefaults.standard.set(selectedExitServer.gateway, forKey: UserDefaults.Key.selectedExitServerGateway)
            UserDefaults.standard.set(selectedExitServer.city, forKey: UserDefaults.Key.selectedExitServerCity)
            UserDefaults.standard.set(selectedExitServer.random, forKey: UserDefaults.Key.selectedExitServerRandom)
            UserDefaults.shared.set(selectedExitServer.getLocationFromGateway(), forKey: UserDefaults.Key.exitServerLocation)
        }
    }
    
    var selectedHost: Host? {
        didSet {
            Host.save(selectedHost, key: UserDefaults.Key.selectedHost)
        }
    }
    
    var selectedExitHost: Host? {
        didSet {
            Host.save(selectedExitHost, key: UserDefaults.Key.selectedExitHost)
        }
    }
    
    var connectionProtocol: ConnectionSettings {
        didSet {
            saveConnectionProtocol()
        }
    }
    
    // MARK: - Initialize -

    init(serverList: VPNServerList) {
        connectionProtocol = ConnectionSettings.getSavedProtocol()
        
        selectedServer = serverList.servers.first ?? ServerModel(gateway: "Not loaded", countryCode: "US", country: "", city: "")
        selectedExitServer = serverList.getExitServer(entryServer: selectedServer)
        
        if let savedCity = UserDefaults.standard.string(forKey: UserDefaults.Key.selectedServerCity) {
            if let lastUsedServer = serverList.getServer(byCity: savedCity) {
                selectedServer = lastUsedServer
            }
        }
        
        if let savedGateway = UserDefaults.standard.string(forKey: UserDefaults.Key.selectedServerGateway) {
            if let lastUsedServer = serverList.getServer(byGateway: savedGateway) {
                selectedServer = lastUsedServer
            }
        }
        
        if let savedExitCity = UserDefaults.standard.string(forKey: UserDefaults.Key.selectedExitServerCity) {
            if let lastUsedServer = serverList.getServer(byCity: savedExitCity) {
                selectedExitServer = lastUsedServer
                selectedExitServer.random = UserDefaults.standard.bool(forKey: UserDefaults.Key.selectedExitServerRandom)
            }
        }
        
        if let savedExitGateway = UserDefaults.standard.string(forKey: UserDefaults.Key.selectedExitServerGateway) {
            if let lastUsedServer = serverList.getServer(byGateway: savedExitGateway) {
                selectedExitServer = lastUsedServer
                selectedExitServer.random = UserDefaults.standard.bool(forKey: UserDefaults.Key.selectedExitServerRandom)
            }
        }
        
        UserDefaults.shared.set(selectedExitServer.getLocationFromGateway(), forKey: UserDefaults.Key.exitServerLocation)
        saveConnectionProtocol()
        
        selectedServer.fastest = UserDefaults.standard.bool(forKey: UserDefaults.Key.selectedServerFastest)
        selectedServer.random = UserDefaults.standard.bool(forKey: UserDefaults.Key.selectedServerRandom)
        
        if let status = NEVPNStatus.init(rawValue: UserDefaults.standard.integer(forKey: UserDefaults.Key.selectedServerStatus)) {
            selectedServer.status2 = status
        }
        
        if selectedHost == nil {
            selectedHost = Host.load(key: UserDefaults.Key.selectedHost)
        }
        
        if selectedExitHost == nil {
            selectedExitHost = Host.load(key: UserDefaults.Key.selectedExitHost)
        }
    }
    
    // MARK: - Methods -
    
    func updateSelectedServerForMultiHop(isEnabled: Bool) {
        if isEnabled && Application.shared.settings.selectedServer.fastest {
            if let server = Application.shared.serverList.getServers().first {
                server.fastest = false
                Application.shared.settings.selectedServer = server
                Application.shared.settings.selectedExitServer = Application.shared.serverList.getExitServer(entryServer: server)
            }
        }
        
        if !isEnabled {
            Application.shared.settings.selectedServer.fastest = UserDefaults.standard.bool(forKey: UserDefaults.Key.fastestServerPreferred)
        }
    }
    
    func updateRandomServer() {
        if Application.shared.settings.selectedServer.random {
            Application.shared.settings.selectedServer = Application.shared.serverList.getRandomServer(isExitServer: false)
        }
        
        if Application.shared.settings.selectedExitServer.random {
            Application.shared.settings.selectedExitServer = Application.shared.serverList.getRandomServer(isExitServer: true)
        }
    }
    
    func saveConnectionProtocol() {
        UserDefaults.standard.set(connectionProtocol.formatSave(), forKey: UserDefaults.Key.selectedProtocol)
    }
    
}


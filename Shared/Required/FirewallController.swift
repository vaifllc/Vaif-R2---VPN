//
//  FirewallController.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 9/18/22.
//

import UIKit
import NetworkExtension
import CocoaLumberjackSwift
import PromiseKit
import WidgetKit

let kFirewallTunnelLocalizedDescription = "Vaif R2 Configuration"

class FirewallController: NSObject {
    
    static let shared = FirewallController()
    
    var manager: NETunnelProviderManager?
    
    private override init() {
        super.init()
        refreshManager()
    }
    
    func refreshManager(completion: @escaping (_ error: Error?) -> Void = {_ in }) {
        // get the reference to the latest manager in Settings
        NETunnelProviderManager.loadAllFromPreferences { (managers, error) -> Void in
            if let managers = managers, managers.count > 0 {
                if (self.manager == managers[0]) {
                    DDLogInfo("Encountered same manager while refreshing manager, not replacing it.")
                    completion(nil)
                }
                self.manager = nil
                self.manager = managers[0]
            }
            completion(error)
        }
    }
    
    func existingManagerCount(completion: @escaping (Int?) -> Void) {
        NETunnelProviderManager.loadAllFromPreferences { (managers, error) in
            completion(managers?.count)
        }
    }
    
    func status() -> NEVPNStatus {
        if manager != nil {
            return manager!.connection.status
        }
        else {
            return .invalid
        }
    }
    
    func deleteConfigurationAndAddAgain() {
        refreshManager { (error) in
            self.manager?.removeFromPreferences(completionHandler: { (removeError) in
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    self.setEnabled(true, isUserExplicitToggle: true)
                }
            })
        }
    }

    func restart(completion: @escaping (_ error: Error?) -> Void = {_ in }) {
        DDLogInfo("FirewallController.restart called")
        // Don't let this affect userWantsFirewallOn/Off config
        FirewallController.shared.setEnabled(false, completion: {
            error in
            DDLogInfo("FirewallController.restart completed disabling")
            // TODO: Handle the error (throw?)
            if error != nil {
                DDLogError("Error disabling on Firewall restart: \(error!)")
            }
            // waiting for a little bit before re-enabling:
            // without it, sometimes Firewall fails to enable
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) {
                DDLogInfo("FirewallController.restart wait completed")
                FirewallController.shared.setEnabled(true, completion: {
                    error in
                    DDLogInfo("FirewallController.restart completed enabling")
                    if error != nil {
                        DDLogError("Error enabling on Firewall restart: \(error!)")
                    }
                    completion(error)
                })
            }
        })
    }
    
    struct CombinedBlockListEmptyError: Error { }
    
    func setEnabled(_ enabled: Bool, isUserExplicitToggle: Bool = false, completion: @escaping (_ error: Error?) -> Void = {_ in }) {
        DDLogInfo("FirewallController set enabled: \(enabled)")
        // only change this boolean if it's user action
        if (isUserExplicitToggle) {
            setUserWantsFirewallEnabled(enabled)
            if #available(iOSApplicationExtension 14.0, iOS 14.0, *) {
                WidgetCenter.shared.reloadAllTimelines()
            }
        }
        
        if enabled && getIsCombinedBlockListEmpty() {
            DDLogError("Trying to enable Firewall when combined block list is empty; not allowing")
            completion(FirewallController.CombinedBlockListEmptyError())
            assertionFailure("Trying to enable Firewall when combined block list is empty; not allowing. This crash only happens in DEBUG mode")
            return
        }
        
        // just to be sure, reload the managers to make sure we don't make multiple configs
        NETunnelProviderManager.loadAllFromPreferences { (managers, error) -> Void in
            if let managers = managers, managers.count > 0 {
                self.manager = nil
                self.manager = managers[0]
            }
            else {
                self.manager = nil
                self.manager = NETunnelProviderManager()
                self.manager!.protocolConfiguration = NETunnelProviderProtocol()
            }
            self.manager!.localizedDescription = kFirewallTunnelLocalizedDescription
            self.manager!.protocolConfiguration?.serverAddress = kFirewallTunnelLocalizedDescription
            self.manager!.isEnabled = enabled
            self.manager!.isOnDemandEnabled = enabled
            
            let connectRule = NEOnDemandRuleConnect()
            connectRule.interfaceTypeMatch = .any
            self.manager!.onDemandRules = [connectRule]
            self.manager!.saveToPreferences(completionHandler: { (error) -> Void in
                // TODO: Handle each case specifically
                if let e = error as? NEVPNError {
                    DDLogError("VPN Error while saving state: \(enabled) \(e)")
                    switch e.code {
                    case .configurationDisabled:
                        break;
                    case .configurationInvalid:
                        break;
                    case .configurationReadWriteFailed:
                        break;
                    case .configurationStale:
                        break;
                    case .configurationUnknown:
                        break;
                    case .connectionFailed:
                        break;
                    @unknown default:
                        break;
                    }
                    completion(nil)
                }
                else if let e = error {
                    DDLogError("Error saving config for enabled state: \(enabled): \(e)")
                    completion(e)
                }
                else {
                    DDLogInfo("Successfully saved config for enabled state: \(enabled)")
                    // manually activate the starting of the tunnel, and also do a dummy connect to a nonexistant, invalid URL to force enabling
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        if (enabled) {
                            DDLogInfo("FirewallController.setEnabled enabled, calling startVPNTunnel")
                            do {
                                try self.manager!.connection.startVPNTunnel()
                                let config = URLSessionConfiguration.default
                                config.requestCachePolicy = .reloadIgnoringLocalCacheData
                                config.urlCache = nil
                                let session = URLSession.init(configuration: config)
                                let url = URL(string: "https://nonexistant_invalid_url")
                                let task = session.dataTask(with: url!) { (data, response, error) in
                                    DDLogInfo("FirewallController.setEnabled response from calling nonexistant url")
                                    return
                                }
                                DDLogInfo("FirewallController.setEnabled calling nonexistant url")
                                task.resume()
                                DDLogInfo("FirewallController.setEnabled refreshing manager")
                                self.refreshManager(completion: { error in
                                    if (error != nil) {
                                        DDLogInfo("FirewallController.setEnabled error response from refreshing manager: \(error!)")
                                    }
                                    else {
                                        DDLogInfo("FirewallController.setEnabled no error from refreshing manager")
                                    }
                                    completion(nil)
                                })
                            }
                            catch {
                                DDLogError("Unable to start the tunnel after saving: " + error.localizedDescription)
                                completion(error.localizedDescription)
                            }
                        }
                        else {
                            DDLogInfo("FirewallController.setEnabled not enabled, no need to call startVPNTunnel")
                            completion(nil)
                        }
                    }
                }
            })
        }
    }
    
}

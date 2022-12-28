//
//  PropertiesManager+Log.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 9/28/22.
//

import Foundation

public extension PropertiesManager {
    
    func logCurrentState() {
        let keysToLog = Set(Keys.allCases).subtracting([Keys.userLocation, Keys.streamingServices, Keys.servicePlans, Keys.defaultPlanDetails, Keys.streamingResourcesUrl])
        
        var message = ""
        for key in keysToLog {
            let value = Storage.userDefaults().value(forKeyPath: key.rawValue)
            message += "\n \(key)=\(value.stringForLog);"
        }
        //log.info("\(message)", category: .settings, event: .current)
    }
    
}


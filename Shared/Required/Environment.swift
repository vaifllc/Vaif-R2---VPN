//
//  Environment.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 9/18/22.
//

import Foundation
import CocoaLumberjackSwift

let vpnSourceID = "-111818" //getEnvironmentVariable(key: "vpnSourceID", default: "-111818")
let vpnDomain = "vaifvpn.net" //getEnvironmentVariable(key: "vpnDomain", default: "confirmedvpn.com")
let vpnRemoteIdentifier = "www" + vpnSourceID + "." + vpnDomain

let mainDomain = "vaifvpn.net" //getEnvironmentVariable(key: "mainDomain", default: "confirmedvpn.com")
let mainURL = "https://www." + mainDomain

let testFirewallDomain = "example.com"

let lastVersionToAskForRating = "024"

func getEnvironmentVariable(key: String, default: String) -> String {
    if let value = ProcessInfo.processInfo.environment[key] {
        return value
    }
    else {
        DDLogError("ERROR: Could not find environment variable key \(key)")
        return ""
    }
}

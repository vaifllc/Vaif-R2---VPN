//
//  UserDefaults.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 9/18/22.
//

import Foundation

let defaults = UserDefaults(suiteName: "group.com.confirmed")!

let kUserWantsFirewallEnabled = "user_wants_firewall_enabled"
let kUserWantsVPNEnabled = "user_wants_vpn_enabled"

enum LatestKnowledge {
    
    private static let kLatestKnowledgeIsFirewallEnabled = "kLatestKnowledgeIsFirewallEnabled"
    private static let kLatestKnowledgeIsVPNEnabled = "kLatestKnowledgeIsVPNEnabled"
    
    static var isFirewallEnabled: Bool {
        get {
            return defaults.bool(forKey: kLatestKnowledgeIsFirewallEnabled)
        }
        set {
            defaults.setValue(newValue, forKey: kLatestKnowledgeIsFirewallEnabled)
        }
    }
    
    static var isVPNEnabled: Bool {
        get {
            return defaults.bool(forKey: kLatestKnowledgeIsVPNEnabled)
        }
        set {
            defaults.setValue(newValue, forKey: kLatestKnowledgeIsVPNEnabled)
        }
    }
    
}

func setUserWantsFirewallEnabled(_ enabled: Bool) {
    defaults.set(enabled, forKey: kUserWantsFirewallEnabled)
}

func getUserWantsFirewallEnabled() -> Bool {
    return defaults.bool(forKey: kUserWantsFirewallEnabled)
}

func setUserWantsVPNEnabled(_ enabled: Bool) {
    defaults.set(enabled, forKey: kUserWantsVPNEnabled)
}

func getUserWantsVPNEnabled() -> Bool {
    return defaults.bool(forKey: kUserWantsVPNEnabled)
}


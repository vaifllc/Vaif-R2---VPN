//
//  CoreString+Plurals.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 9/26/22.
//

import Foundation

public extension LocalizedString {
    
    // Only plural strings should be placed here

    /// Plan details price time period n months
    var _pu_plan_details_price_time_period_m: String {
        NSLocalizedString("for %d months", bundle: Common.bundle, comment: "Plan details price time period n months")
    }
    
    /// Plan details price time period n years
    var _pu_plan_details_price_time_period_y: String { NSLocalizedString("for %d years", bundle: Common.bundle, comment: "Plan details price time period n years")
    }
    
    /// Plan details n users
    var _pu_plan_details_n_users: String {
        NSLocalizedString("%d users", bundle: Common.bundle, comment: "Plan details n users")
    }
    
    /// Plan details n addresses
    var _pu_plan_details_n_addresses: String {
        NSLocalizedString("%d email addresses", bundle: Common.bundle, comment: "Plan details n addresses")
    }

    /// Plan details n addresses per user
    var _pu_plan_details_n_addresses_per_user: String { NSLocalizedString("%d email addresses / user", bundle: Common.bundle, comment: "Plan details n address per user")
    }
    
    /// Plan details n calendars
    var _pu_plan_details_n_calendars: String {
        NSLocalizedString("%d calendars", bundle: Common.bundle, comment: "Plan details n calendar")
    }
    
    /// Plan details n folders / labels
    var _pu_plan_details_n_folders: String {
        NSLocalizedString("%d folders / labels", bundle: Common.bundle, comment: "Plan details n folders / labels")
    }
    
    /// Plan details n countries
    var _pu_plan_details_countries: String {
        NSLocalizedString("%d countries", bundle: Common.bundle, comment: "Plan details n countries")
    }
    
    /// Plan details n calendars per user
    var _pu_plan_details_n_calendars_per_user: String {
        NSLocalizedString("%d calendars / user", bundle: Common.bundle, comment: "Plan details n calendars per user")
    }
    
    /// Plan details n connections
    var _pu_plan_details_n_connections: String {
        NSLocalizedString("%d connections", bundle: Common.bundle, comment: "Plan details n connections")
    }
    
    /// Plan details n VPN connections
    var _pu_plan_details_n_vpn_connections: String {
        NSLocalizedString("%d VPN connections", bundle: Common.bundle, comment: "Plan details n VPN connections")
    }
    
    /// Plan details n high-speed connections
    var _pu_plan_details_n_high_speed_connections: String {
        NSLocalizedString("%d high-speed VPN connections", bundle: Common.bundle, comment: "Plan details n high-speed connections")
    }
    
    /// Plan details n high-speed connections per user
    var _pu_plan_details_n_high_speed_connections_per_user: String {
        NSLocalizedString("%d high-speed VPN connections / user", bundle: Common.bundle, comment: "Plan details n connections per user")
    }
    
    /// Plan details n custom domains
    var _pu_plan_details_n_custom_domains: String {
        NSLocalizedString("%d custom domains", bundle: Common.bundle, comment: "Plan details n custom domains")
    }

    /// Plan details n addresses & calendars
    var _pu_plan_details_n_addresses_and_calendars: String {
        NSLocalizedString("%d addresses & calendars", bundle: Common.bundle, comment: "Plan details n addresses & calendars")
    }
}

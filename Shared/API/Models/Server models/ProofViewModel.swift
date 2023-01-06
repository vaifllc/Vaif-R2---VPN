//
//  ProofViewModel.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 1/2/23.
//

import UIKit
import NetworkExtension

struct ProofsViewModel {
    
    // MARK: - Properties -
    
    var model: GeoLookup?
    var displayMode: DisplayMode?
    
    var imageNameForCountryCode: String {
        return model?.countryCode.uppercased() ?? ""
    }
    
    var ipAddress: String {
        return model?.ipAddress ?? ""
    }
    
    var city: String {
        return model?.city ?? ""
    }
    
    var latitude: Double {
        return model?.latitude ?? 0
    }
    
    var longitude: Double {
        return model?.longitude ?? 0
    }
    
    var countryCode: String {
        return model?.countryCode ?? ""
    }
    
    var location: String {
        guard let model = model else {
            return ""
        }
        
        guard !model.city.isEmpty else {
            return model.country
        }
        
        return "\(model.city), \(model.countryCode)"
    }
    
    var provider: String {
        guard let model = model else {
            return ""
        }
        
        return model.isIvpnServer ? "IVPN" : model.isp
    }
    
    var isIvpnServer: Bool {
        guard let model = model else {
            return false
        }
        
        return model.isIvpnServer
    }
    
    // MARK: - Initialize -
    
    init(model: GeoLookup? = nil, displayMode: DisplayMode? = nil) {
        self.model = model
        self.displayMode = displayMode
    }
    
}

extension ProofsViewModel {
    
    enum DisplayMode {
        case loading
        case content
        case error
    }
    
}

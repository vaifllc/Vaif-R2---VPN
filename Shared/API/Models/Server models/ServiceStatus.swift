//
//  ServiceStatus.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 1/2/23.
//

import Foundation

struct ServiceStatus: Codable {
    
    // MARK: - Properties -
    
    var isActive: Bool
    #warning("currentPlan should not be optional, change this after API is fixed")
    var currentPlan: String?
    var activeUntil: Int?
    var isOnFreeTrial: Bool?
    var username: String?
    let upgradeToUrl: String?
    let paymentMethod: String?
    let capabilities: [String]?
    
    // MARK: - Initialize -
    
    init() {
        let service = ServiceStatus.load()
        isActive = service?.isActive ?? true
        currentPlan = service?.currentPlan ?? nil
        activeUntil = service?.activeUntil ?? nil
        isOnFreeTrial = service?.isOnFreeTrial ?? false
        username = service?.username ?? nil
        upgradeToUrl = service?.upgradeToUrl ?? nil
        paymentMethod = service?.paymentMethod ?? nil
        capabilities = service?.capabilities ?? nil
    }
    
    // MARK: - Methods -
    
    func save() {
        if let encoded = try? JSONEncoder().encode(self) {
            UserDefaults.standard.set(encoded, forKey: UserDefaults.Key.serviceStatus)
        }
    }
    
    static func load() -> ServiceStatus? {
        if let saved = UserDefaults.standard.object(forKey: UserDefaults.Key.serviceStatus) as? Data {
            if let loaded = try? JSONDecoder().decode(ServiceStatus.self, from: saved) {
                return loaded
            }
        }
        
        return nil
    }
    
    func activeUntilString() -> String {
        return Date(timeIntervalSince1970: TimeInterval(activeUntil ?? 0)).formatDate()
    }
    
    func isEnabled(capability: Capability) -> Bool {
        if let capabilities = self.capabilities {
            return capabilities.contains(capability.rawValue)
        }

        return false
    }
    
    static func isValid(username: String) -> Bool {
        return username.hasPrefix("ivpn") || username.hasPrefix("i-")
    }
    
    static func isValid(verificationCode: String) -> Bool {
        return !verificationCode.isEmpty && verificationCode.count == 6 && NumberFormatter().number(from: verificationCode) != nil
    }
    
    func isNewStyleAccount() -> Bool {
        return paymentMethod == "prepaid"
    }
    
    func daysUntilSubscriptionExpiration() -> Int {
        let calendar = Calendar.current
        let startDate = Date()
        let endDate = Date(timeIntervalSince1970: TimeInterval(activeUntil ?? 0))
        let date1 = calendar.startOfDay(for: startDate)
        let date2 = calendar.startOfDay(for: endDate)
        let components = calendar.dateComponents([.day], from: date1, to: date2)
        let diff = components.day ?? 0
        
        return diff > 0 ? diff : 0
    }
    
    func isActiveUntilValid() -> Bool {
        return activeUntil != nil
    }
    
    func activeUntilExpired() -> Bool {
        let activeUntilDate = Date(timeIntervalSince1970: TimeInterval(activeUntil ?? 0))
        return Date() > activeUntilDate
    }
    
//    func isLegacyAccount() -> Bool {
//        let accountId = KeyChain.username ?? ""
//        guard let currentPlan = currentPlan else {
//            return false
//        }
//
//        if accountId.hasPrefix("ivpn") && currentPlan.hasPrefix("IVPN Pro") && currentPlan != "IVPN Pro" {
//            return true
//        }
//
//        return false
//    }
    
}


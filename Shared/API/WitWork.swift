//
//  WitWork.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 12/16/22.
//

import Foundation
import DeviceKit
import GBDeviceInfo
import UIKit
import FirebaseAuth

/// CONFIG
let k_subscription       = "Subscription"
var k_title_vpn: String = "VPN"
var k_title_premium: String = "PREMIUM"
var k_title_profile: String = "PROFILE"
var k_followId: String = "followId"
var k_user: String = "user"



struct Define {
    let cl_navigation: UIColor = .init(named: "cl_navigation")!
    
    func font_bold(size: Int) -> UIFont {
        return .init(name: "WorkSans-Bold", size: CGFloat(size)) ?? UIFont.boldSystemFont(ofSize: CGFloat(size))
    }
    
    func font_medium(size: Int) -> UIFont {
        return .init(name: "WorkSans-Medium", size: CGFloat(size)) ?? UIFont.systemFont(ofSize: CGFloat(size))
    }
    
    func font_regular(size: Int) -> UIFont {
        return .init(name: "WorkSans-Regular", size: CGFloat(size)) ?? UIFont.systemFont(ofSize: CGFloat(size))
    }
    
    func font_thin(size: Int) -> UIFont {
        return .init(name: "WorkSans-Thin", size: CGFloat(size)) ?? UIFont.systemFont(ofSize: CGFloat(size))
    }
    
    struct itunes {
        static let secret_key                   =        "8d740f4cece34a0485e2066e87bc9c3a"
        #if DEBUG
            static let verify_receipt           = URL(string: "https://sandbox.itunes.apple.com/verifyReceipt")!
        #else
            static let verify_receipt           = URL(string: "https://buy.itunes.apple.com/verifyReceipt")!
        #endif
    }
    
}

class WitWork: NSObject {
    static var shared: WitWork! = .init()
    
    let device = Device.current
    let gbDevice: GBDeviceInfo! =  GBDeviceInfo.deviceInfo()
    lazy var user: User? = Auth.auth().currentUser
    var serversData: [ServerModel] = []
    func getDeviceInfo() -> [String: Any]{
        
        
        let battery = device.batteryLevel ?? 0
        let isGuidedAccessSessionActive: Int = device.isGuidedAccessSessionActive ? 1 : 0
        let screenBrightness = device.screenBrightness
        let model = self.gbDevice.modelString ?? ""
        let family = self.gbDevice.family.rawValue
        let physicalMemory = self.gbDevice.physicalMemory
        let rawSystemInfoString = self.gbDevice.rawSystemInfoString
        let pixelsPerInch = self.gbDevice.displayInfo.pixelsPerInch
        let display = self.gbDevice.displayInfo.display.rawValue
        let jailbroken = self.gbDevice.isJailbroken
        let deviceVersion = self.gbDevice.deviceVersion

        return [
            "battery": battery,
            "isGuidedAccessSessionActive": isGuidedAccessSessionActive,
            "screenBrightness": screenBrightness,
            "model": model,
            "family": family,
            "physicalMemory": physicalMemory,
            "rawSystemInfoString": rawSystemInfoString ?? "",
            "pixelsPerInch": pixelsPerInch,
            "display": display,
            "jailbroken": jailbroken,
            "deviceVersion": deviceVersion
        ]
    }
    
    func logout() {
        UserDefaults.standard.removeObject(forKey: k_user)
        UserDefaults.standard.synchronize()
    }
    
    func removeFollower() {
        UserDefaults.standard.removeObject(forKey: k_followId)
        UserDefaults.standard.synchronize()
    }
    
    //MARK: - Subscription
    func getSubscription() -> PaidSubscription? {
        guard let subscription = UserDefaults.standard.object(forKey: k_subscription) as? Data else{
            return nil
        }
        return PaidSubscription(data: subscription)
    }
    func set(subscription: PaidSubscription) {
        UserDefaults.standard.set(subscription.encode(), forKey: k_subscription)
        UserDefaults.standard.synchronize()
    }
}

public struct WP_Error: Error {
    let msg: String
    
    static func unknow() -> Error {
        return WP_Error(msg: "Unknow Error")
    }
}

extension WP_Error: LocalizedError {
    public var errorDescription: String? {
        return NSLocalizedString(msg, comment: "")
    }
}


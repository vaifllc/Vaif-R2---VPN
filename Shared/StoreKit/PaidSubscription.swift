//
//  PaidSubscription.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 12/16/22.
//

import Foundation
import SwiftDate
private let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd HH:mm:ss VV"
    
    return formatter
}()

public struct PaidSubscription {
    
    public enum Level: Int {
        case month = 0
        case year = 1
        case lifetime = 2
        case unknow = 3

        func description() -> String {
            switch self {
            case .lifetime:
                return "io.wizstudio.insafe.lifetimex"
            case .year:
                return "io.wizstudio.insafe.annually"
            case .month:
                return "io.wizstudio.insafe.monthly"
            default:
                return ""
            }
        }
        init(productId: String) {
            switch productId {
            case "io.wizstudio.insafe.lifetimex":
                self = .lifetime
            case "io.wizstudio.insafe.monthly":
                self = .month
            case "io.wizstudio.insafe.annually":
                self = .year
            default:
                self = .unknow
            }
        }
    }
    
    public var productId: String
    public let purchaseDate: Date
    public let expiresDate: Date
    public var level: Level
    public var is_trial_period: Bool
    public var isActive: Bool {
        // is current date between purchaseDate and expiresDate?
        debugPrint("------------")
        debugPrint("productId: \(self.productId)")
        debugPrint("purchase date: \(purchaseDate.debugDescription)\n")
        debugPrint("current date: \(Date().debugDescription)\n")
        debugPrint("expires date: \(expiresDate.debugDescription)\n")
        debugPrint("------------")
        if self.productId == Level.lifetime.description() || self.is_trial_period == true  {
            return true
        }
        return (purchaseDate...expiresDate).contains(Date())
    }
    
    init?(json: [String: Any]) {
        if let pdId = json["product_id"] as? String,
            pdId == Level.lifetime.description(){
            self.productId = pdId
            self.purchaseDate = Date()
            self.expiresDate = Date()
            self.level = .lifetime
            self.is_trial_period = true
        }else {
            guard
                let productId = json["product_id"] as? String,
                let purchaseDateString = json["purchase_date"] as? String,
                let purchaseDate = purchaseDateString.toISODate()?.date, //dateFormatter.date(from: purchaseDateString),
                let expiresDateString = json["expires_date"] as? String,
                let expiresDate =  expiresDateString.toISODate()?.date //dateFormatter.date(from: expiresDateString)
                else {
                    
                    return nil
            }
            
            self.productId = productId
            self.purchaseDate = purchaseDate
            self.expiresDate = expiresDate
            self.level = Level(productId: productId)
            self.is_trial_period = json["is_trial_period"] as? Bool ?? false
        }
    }
}


extension PaidSubscription {
    init?(data: Data) {
        if let coding = NSKeyedUnarchiver.unarchiveObject(with: data) as? Encoding {
            productId = coding.productId as String
            purchaseDate = coding.purchaseDate as Date
            expiresDate = coding.expiresDate as Date
            level = Level(productId: productId)
            is_trial_period = coding.is_trial_period as Bool
        } else {
            return nil
        }
    }
    
    func encode() -> Data {
        return NSKeyedArchiver.archivedData(withRootObject: Encoding(self))
    }
    
    @objc(_TtCV13Wallpaper_Now16PaidSubscription8Encoding)class Encoding: NSObject, NSCoding {
        
        let productId: NSString
        let purchaseDate: NSDate
        let expiresDate: NSDate
        let is_trial_period: Bool
        init(_ paid: PaidSubscription) {
            productId = paid.productId as NSString
            purchaseDate = paid.purchaseDate as NSDate
            expiresDate = paid.expiresDate as NSDate
            is_trial_period = paid.is_trial_period as Bool
        }
        
        @objc required init?(coder aDecoder: NSCoder) {
            self.productId = aDecoder.decodeObject(forKey: "productId") as! NSString
            self.purchaseDate = aDecoder.decodeObject(forKey: "purchaseDate") as! NSDate
            self.expiresDate = aDecoder.decodeObject(forKey: "expiresDate") as! NSDate
            self.is_trial_period = aDecoder.decodeBool(forKey: "is_trial_period")
        }
        
        @objc func encode(with aCoder: NSCoder) {
            aCoder.encode(productId, forKey: "productId")
            aCoder.encode(purchaseDate, forKey: "purchaseDate")
            aCoder.encode(expiresDate, forKey: "expiresDate")
            aCoder.encode(is_trial_period, forKey: "is_trial_period")
        }
    }
}


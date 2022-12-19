//
//  StoreKit.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 12/17/22.
//

import Foundation
import SwiftyStoreKit
import StoreKit
import PromiseKit

typealias SessionPurchase = (sessionId: String, currentSubscription: PaidSubscription?)

class StoreKit {
    static var shared: StoreKit = StoreKit()
    private var sessions = [SessionId: R1Session]()
    private var sessionPurchase: SessionPurchase? = nil
    var products: [SKProduct] = []
    let simulatedStartDate: Date
     func isActivePaidSubscription() -> Bool { // avoid to this class calling when the first time init
        if let sessionPurchase = StoreKit.shared.sessionPurchase {
            if let paid = sessionPurchase.currentSubscription, // already paid ?
                paid.isActive == true {
                return true
            }
        }
        return false
    }
    func getPlanSubscription() -> PaidSubscription? {
        if let sessionPurchase = StoreKit.shared.sessionPurchase {
            if let paid = sessionPurchase.currentSubscription {
                return paid
            }
        }
        return nil
    }
        
    init() {
        let persistedDateKey = "WPPDate"
        if let persistedDate = UserDefaults.standard.object(forKey: persistedDateKey) as? Date {
            simulatedStartDate = persistedDate
        } else {
            let date = Date().addingTimeInterval(-30) // 30 second difference to account for server/client drift.
            UserDefaults.standard.set(date, forKey: "WPPDate")
            simulatedStartDate = date
        }
        
        guard let subscription = WitWork.shared.getSubscription() else {
            return
        }
        self.sessionPurchase = SessionPurchase(sessionId: UUID().uuidString, currentSubscription: subscription)
    }
    
    @discardableResult
    func loadReceipt() -> Promise<Data> {
        return Promise { seal in
            if let data = self.loadReceiptData() {
                seal.fulfill(data)
            }else {
                let error = WP_Error(msg: "Nothing to load")
                seal.reject(error)
            }
        }
    }
    
    @discardableResult
    func retriveProduct(products: [String]) -> Promise<[SKProduct]>{
        return Promise { seal in
            if self.products.count > 0 {
                seal.fulfill(self.products)
            }else {
                let productSet = Set(products.compactMap({ $0 }))
                SwiftyStoreKit.retrieveProductsInfo(productSet) { (result) in
                                                        if result.retrievedProducts.count > 0 {
                                                            let products = Array(result.retrievedProducts)
                                                            self.products = products
                                                            seal.fulfill(products)
                                                        }
                                                        else {
                                                            if let error = result.error {
                                                                seal.reject(error)
                                                            }else {
                                                                let error = WP_Error(msg: "Error when fetch product")
                                                                seal.reject(error)
                                                            }
                                                        }
                }
            }
        }
    }
    
    @discardableResult
    func restore() -> Promise<SessionPurchase> {
        return self.fetchReceiption()
    }
    
    @discardableResult
    func purchase(skProduct: SKProduct) -> Promise<PurchaseDetails> {
        return Promise { seal in
            SwiftyStoreKit.purchaseProduct(skProduct, quantity: 1, atomically: true, completion: { (result) in
                switch result {
                case .success( let success):
                    // finish it
                    if success.needsFinishTransaction {
                        SwiftyStoreKit.finishTransaction(success.transaction)
                    }
                    self.fetchReceiption().done({ (result) in
                        seal.fulfill(success)
                    }).catch({ (error) in
                        seal.reject(error)
                    }).finally {}
                    break
                case .error(let error):
                    var strError = error.localizedDescription
                    switch error.code {
                        case .unknown: strError = "Unknown error. Please contact support"
                        case .clientInvalid: strError = "Not allowed to make the payment"
                        case .paymentCancelled: break
                        case .paymentInvalid: strError = "The purchase identifier was invalid"
                        case .paymentNotAllowed: strError = "The device is not allowed to make the payment"
                        case .storeProductNotAvailable: strError = "The product is not available in the current storefront"
                        case .cloudServicePermissionDenied: strError = "Access to cloud service information is not allowed"
                        case .cloudServiceNetworkConnectionFailed: strError = "Could not connect to the network"
                        case .cloudServiceRevoked: strError = "User has revoked permission to use this cloud service"
                        default: break
                    }
                    let wp_error = WP_Error(msg: strError)
                    seal.reject(wp_error)
                    break
                }
            })
        }
    }
    
    func verifySubscription(productId: String) -> Promise<PaidSubscription> {

        return Promise { seal in
            var appleValidator: AppleReceiptValidator = AppleReceiptValidator(service: .production, sharedSecret: Define.itunes.secret_key)
            #if DEBUG
            appleValidator = AppleReceiptValidator(service: .sandbox, sharedSecret: Define.itunes.secret_key)
            #endif
            SwiftyStoreKit.verifyReceipt(using: appleValidator) { result in
                var strError = ""
                switch result {
                case .success(let receipt):
                    // Verify the purchase of a Subscription
                    let purchaseResult = SwiftyStoreKit.verifySubscription(
                        ofType: .autoRenewable,
                        productId: productId,
                        inReceipt: receipt)
                    switch purchaseResult {
                    case .purchased(let expiryDate, let items):
                        let activeSubscriptions = items.filter { item in
                            guard let expiredDate = item.subscriptionExpirationDate else { return false }
                            return (item.purchaseDate...expiredDate).contains(Date())
                        }
                        let sortedByMostRecentPurchase = activeSubscriptions.sorted { $0.purchaseDate > $1.purchaseDate }
                        if let active = sortedByMostRecentPurchase.first {
                            let paid = PaidSubscription(productId: productId,
                                             purchaseDate: active.purchaseDate, expiresDate: expiryDate, is_trial_period: active.isTrialPeriod)
                            WitWork.shared.set(subscription: paid)
                            print(paid)
                            print("\(productId) is valid until \(expiryDate)\n\(items)\n")
                            seal.fulfill(paid)
                        }else {
                            seal.reject(WP_Error(msg: "unknow"))
                        }
                     
                        
                    case .expired(let expiryDate, let items):
                        strError = "\(productId) is expired since \(expiryDate)\n\(items)\n"
                    case .notPurchased:
                        strError = "The user has never purchased"
                    }
                case .error(let error):
                    strError = "Receipt verification failed: \(error)"
                }
                let error = WP_Error(msg: strError)
                seal.reject(error)
            }
        }
    }

    func fetchReceiption() -> Promise<SessionPurchase> {
        return Promise { seal in
            SwiftyStoreKit.fetchReceipt(forceRefresh: true) { result in
                switch result {
                case .success(let data):
                    let body = [
                        "receipt-data": data.base64EncodedString(),
                        "password": Define.itunes.secret_key
                    ]

                    let bodyData = try! JSONSerialization.data(withJSONObject: body, options: [])
                    var url: URL = URL(string: "https://buy.itunes.apple.com/verifyReceipt")!
                    if self.isAppStoreReceiptSandbox() == true {
                        url = URL(string: "https://sandbox.itunes.apple.com/verifyReceipt")!
                    }
                    var request = URLRequest(url: url)
                    print("request: \(request)")
                    request.httpMethod = "POST"
                    request.httpBody = bodyData
                    let task = URLSession.shared.dataTask(with: request) { (responseData, response, error) in
                        if let error = error {
                            seal.reject(error)
                        } else if let responseData = responseData {
                            let json = try! JSONSerialization.jsonObject(with: responseData, options: []) as! Dictionary<String, Any>
                            let session = R1Session(receiptData: data, parsedReceipt: json)
                            self.sessions[session.id] = session
                            let subscription = (sessionId: session.id, currentSubscription: session.currentSubscription)
                            print(subscription)
                            // get current session from user default
                            if let currentSubscription = subscription.currentSubscription,
                                currentSubscription.isActive == true {
                                WitWork.shared.set(subscription: currentSubscription)
                            }
                            StoreKit.shared.sessionPurchase = subscription
                            seal.fulfill(subscription)
                        }
                    }
                    task.resume()
                case .error(let error):
                    print("Fetch receipt failed: \(error)")
                    let wp_error = WP_Error(msg: "☹️Unknow error. Please contact support!")
                    seal.reject(wp_error)
                }
            }
        }
        
    }
    func restorePurchases() {
        SKPaymentQueue.default().restoreCompletedTransactions()
    }
    @objc func setupIAP() {
        SwiftyStoreKit.completeTransactions(atomically: true) { purchases in
            for purchase in purchases {
                switch purchase.transaction.transactionState {
                case .purchased, .restored:
                    let downloads = purchase.transaction.downloads
                    if !downloads.isEmpty {
                        SwiftyStoreKit.start(downloads)
                    } else if purchase.needsFinishTransaction {
                        // Deliver content from server, then:
                        SwiftyStoreKit.finishTransaction(purchase.transaction)
                    }
                    let _ = self.verifySubscription(productId: purchase.productId)
                    print("\(purchase.transaction.transactionState.debugDescription): \(purchase.productId)")
                case .failed, .purchasing, .deferred:
                    print("failed")
                    break // do nothing
                default:
                    break
                }
            }
        }
        
        SwiftyStoreKit.updatedDownloadsHandler = { downloads in
            // contentURL is not nil if downloadState == .finished
            let contentURLs = downloads.compactMap { $0.contentURL }
            if contentURLs.count == downloads.count {
                print("Saving: \(contentURLs)")
                SwiftyStoreKit.finishTransaction(downloads[0].transaction)
            }
        }
    }
    
    private func loadReceiptData() -> Data? {
        guard let url = Bundle.main.appStoreReceiptURL else {
            return nil
        }
        
        do {
            let data = try Data(contentsOf: url)
            return data
        } catch {
            print("Error loading receipt data: \(error.localizedDescription)")
            return nil
        }
    }
    
    // MARK: Public
     func isRunningInTestFlightEnvironment() -> Bool {
         if isSimulator() {
             return false
         } else {
             if isAppStoreReceiptSandbox() && !hasEmbeddedMobileProvision() {
                 return true
             } else {
                 return false
             }
         }
     }
     
     func isRunningInAppStoreEnvironment() -> Bool {
         if isSimulator(){
             return false
         } else {
             if isAppStoreReceiptSandbox() || hasEmbeddedMobileProvision() {
                 return false
             } else {
                 return true
             }
         }
     }

     // MARK: Private
     private func hasEmbeddedMobileProvision() -> Bool {
         guard Bundle.main.path(forResource: "embedded", ofType: "mobileprovision") == nil else {
             return true
         }
         return false
     }
     
     private func isAppStoreReceiptSandbox() -> Bool {
         
         if isSimulator() {
             return false
         } else {
             guard let url = Bundle.main.appStoreReceiptURL else {
                 return false
             }
             guard url.lastPathComponent == "sandboxReceipt" else {
                 return false
             }
             return true
         }
     }
     
     private func isSimulator() -> Bool {
         
         #if arch(i386) || arch(x86_64)
         return true
         #else
         return false
         #endif
     }
}

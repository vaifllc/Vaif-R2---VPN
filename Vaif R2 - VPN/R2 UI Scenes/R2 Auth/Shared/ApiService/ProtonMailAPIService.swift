//
//  ProtonMailAPIService.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 9/29/22.
//

import Foundation


#if canImport(TrustKit)
import TrustKit
#endif

// MARK: - Public API types

public protocol TrustKitProvider {
    var noTrustKit: Bool { get }
    var trustKit: TrustKit? { get }
}

public protocol URLCacheInterface {
    func removeAllCachedResponses()
}

extension URLCache: URLCacheInterface {}

public enum PMAPIServiceTrustKitProviderWrapper: TrustKitProvider {
    case instance
    public var noTrustKit: Bool { PMAPIService.noTrustKit }
    public var trustKit: TrustKit? { PMAPIService.trustKit }
}

public class PMAPIService: APIService {
    public func request(method: HTTPMethod2, path: String, parameters: Any?, headers: [String : Any]?, authenticated: Bool, autoRetry: Bool, customAuthCredential: AuthCredential?, nonDefaultTimeout: TimeInterval?, completion: CompletionBlock?) {
        print("lol")
    }
    

   // public weak var forceUpgradeDelegate: ForceUpgradeDelegate?
    
    public weak var humanDelegate: HumanVerifyDelegate?
    
    public weak var authDelegate: AuthDelegate?
    
    public weak var serviceDelegate: APIServiceDelegate?
    
    public static var noTrustKit: Bool = false
    public static var trustKit: TrustKit?
    
    /// the session ID. this can be changed
    public var sessionUID: String = ""
    
    public var doh: DoH & ServerConfig
//    public var doh: DoHInterface & ServerConfig
    
    public var signUpDomain: String {
        return self.doh.getSignUpString()
    }
    
    private(set) var session: Session
    
    //private(set) var isHumanVerifyUIPresented: Atomic<Bool> = .init(false)
    //private(set) var isForceUpgradeUIPresented: Atomic<Bool> = .init(false)
    
    let hvDispatchGroup = DispatchGroup()
    let fetchAuthCredentialsAsyncQueue = DispatchQueue(label: "ch.proton.api.credential_fetch_async", qos: .userInitiated)
    let fetchAuthCredentialsSyncSerialQueue = DispatchQueue(label: "ch.proton.api.credential_fetch_sync", qos: .userInitiated)
    let fetchAuthCredentialCompletionBlockBackgroundQueue = DispatchQueue(
        label: "ch.proton.api.refresh_completion", qos: .userInitiated, attributes: [.concurrent]
    )
    
    /// by default will create a non auth api service. after calling the auth function, it will set the session. then use the delation to fetch the auth data  for this session.
    public required init(doh: DoH & ServerConfig,
                         sessionUID: String = "",
                         sessionFactory: SessionFactoryInterface = SessionFactory.instance,
                         cacheToClear: URLCacheInterface = URLCache.shared,
                         trustKitProvider: TrustKitProvider = PMAPIServiceTrustKitProviderWrapper.instance) {
        self.doh = doh
        
        self.sessionUID = sessionUID
        
        cacheToClear.removeAllCachedResponses()
        
        let apiHostUrl = self.doh.getCurrentlyUsedHostUrl()
        self.session = sessionFactory.createSessionInstance(url: apiHostUrl)
        
        self.session.setChallenge(noTrustKit: trustKitProvider.noTrustKit, trustKit: trustKitProvider.trustKit)
        
        doh.setUpCookieSynchronization(storage: self.session.sessionConfiguration.httpCookieStorage)
    }
    
    public func getSession() -> Session? {
        return session
    }
    
    public func setSessionUID(uid: String) {
        self.sessionUID = uid
    }
}

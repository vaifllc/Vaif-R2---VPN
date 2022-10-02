//
//  HumanCheckHelper.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 9/30/22.
//

import UIKit
import Foundation

public class HumanCheckHelper: HumanVerifyDelegate {
    private let rootViewController: UIViewController?
    private let nonModalUrls: [URL]?
    private weak var responseDelegate: HumanVerifyResponseDelegate?
    private weak var paymentDelegate: HumanVerifyPaymentDelegate?
    private let apiService: APIService
    private let supportURL: URL
    private var verificationCompletion: ((HumanVerifyFinishReason) -> Void)?
//    var coordinator: HumanCheckMenuCoordinator?
//    private var coordinatorV3: HumanCheckV3Coordinator?
    private let clientApp: ClientApp
    
    public let version: HumanVerificationVersion
    
    @available(*, deprecated, message: "Please use the initializer that specifies the human verification version")
    public convenience init(apiService: APIService,
                            supportURL: URL? = nil,
                            viewController: UIViewController? = nil,
                            nonModalUrls: [URL]? = nil,
                            clientApp: ClientApp,
                            responseDelegate: HumanVerifyResponseDelegate? = nil,
                            paymentDelegate: HumanVerifyPaymentDelegate? = nil) {
        self.init(apiService: apiService, supportURL: supportURL, viewController: viewController, nonModalUrls: nonModalUrls, clientApp: clientApp, versionToBeUsed: .v2, responseDelegate: responseDelegate, paymentDelegate: paymentDelegate)
    }

    public init(apiService: APIService,
                supportURL: URL? = nil,
                viewController: UIViewController? = nil,
                nonModalUrls: [URL]? = nil,
                clientApp: ClientApp,
                versionToBeUsed: HumanVerificationVersion,
                responseDelegate: HumanVerifyResponseDelegate? = nil,
                paymentDelegate: HumanVerifyPaymentDelegate? = nil) {
        self.apiService = apiService
        self.supportURL = supportURL ?? HVCommon.defaultSupportURL(clientApp: clientApp)
        self.rootViewController = viewController
        self.nonModalUrls = nonModalUrls
        self.clientApp = clientApp
        self.version = versionToBeUsed
        self.responseDelegate = responseDelegate
        self.paymentDelegate = paymentDelegate
    }

//    public func onHumanVerify(parameters: HumanVerifyParameters, currentURL: URL?, error: NSError, completion: (@escaping (HumanVerifyFinishReason) -> Void)) {
//        
//        // check if payment token exists
//        if let paymentToken = paymentDelegate?.paymentToken {
//            let client = TestApiClient(api: self.apiService)
//            let route = client.createHumanVerifyRoute(destination: nil, type: VerifyMethod(predefinedMethod: .payment), token: paymentToken)
//            // retrigger request and use header with payment token
//            completion(.verification(header: route.header, verificationCodeBlock: { result, _, verificationFinishBlock in
//                self.paymentDelegate?.paymentTokenStatusChanged(status: result == true ? .success : .fail)
//                if result {
//                    verificationFinishBlock?()
//                } else {
//                    // if request still has an error, start human verification UI
//                    self.startMenuCoordinator(parameters: parameters, currentURL: currentURL, completion: completion)
//                }
//            }))
//        } else {
//            // start human verification UI
//            startMenuCoordinator(parameters: parameters, currentURL: currentURL, completion: completion)
//        }
//    }

    public func getSupportURL() -> URL {
        return supportURL
    }
    
//    private func startMenuCoordinator(parameters: HumanVerifyParameters, currentURL: URL?, completion: (@escaping (HumanVerifyFinishReason) -> Void)) {
//        switch version {
//        case .v2:
//            // filter only methods allowed by HV v2
//            var parameters = parameters
//            parameters.methods = parameters.methods.compactMap { VerifyMethod(predefinedString: $0.method) }
//            prepareCoordinator(parameters: parameters)
//        case .v3:
//            prepareV3Coordinator(parameters: parameters, currentURL: currentURL)
//        }
//        responseDelegate?.onHumanVerifyStart()
//        verificationCompletion = completion
//    }
    
//    private func prepareCoordinator(parameters: HumanVerifyParameters) {
//        DispatchQueue.main.async {
//            self.coordinator = HumanCheckMenuCoordinator(rootViewController: self.rootViewController, apiService: self.apiService, parameters: parameters, clientApp: self.clientApp)
//            self.coordinator?.delegate = self
//            self.coordinator?.start()
//        }
//    }
    
//    private func prepareV3Coordinator(parameters: HumanVerifyParameters, currentURL: URL?) {
//        var isModalPresentation = true
//        if nonModalUrls?.first(where: { $0 == currentURL }) != nil {
//            isModalPresentation = false
//        }
//        DispatchQueue.main.async {
//            self.coordinatorV3 = HumanCheckV3Coordinator(rootViewController: self.rootViewController, isModalPresentation: isModalPresentation, apiService: self.apiService, parameters: parameters, clientApp: self.clientApp)
//            self.coordinatorV3?.delegate = self
//            self.coordinatorV3?.start()
//        }
//    }
    
//    @discardableResult
//    public static func removeHumanVerification(from navigationController: UINavigationController?) -> Bool {
//        guard var viewControllers = navigationController?.viewControllers else { return false }
//        var hvIndex: Int?
//        for (index, vc) in viewControllers.enumerated() where vc is HumanVerifyV3ViewController {
//            hvIndex = index
//            break
//        }
//        guard let index = hvIndex else { return false }
//        viewControllers.remove(at: index)
//        navigationController?.viewControllers = viewControllers
//        return true
//    }
}

//extension HumanCheckHelper: HumanCheckMenuCoordinatorDelegate {
//    func verificationCode(tokenType: TokenType, verificationCodeBlock: @escaping (SendVerificationCodeBlock)) {
//        let client = TestApiClient(api: self.apiService)
//        let route = client.createHumanVerifyRoute(destination: tokenType.destination, type: tokenType.verifyMethod, token: tokenType.token)
//        responseDelegate?.humanVerifyToken(token: tokenType.token, tokenType: tokenType.verifyMethod?.method)
//        verificationCompletion?(.verification(header: route.header, verificationCodeBlock: { result, error, finish in
//            verificationCodeBlock(result, error, finish)
//            if result {
//                self.responseDelegate?.onHumanVerifyEnd(result: .success)
//            }
//        }))
//    }
//
//    func close() {
//        verificationCompletion?(.close)
//        self.responseDelegate?.onHumanVerifyEnd(result: .cancel)
//    }
//
//    func closeWithError(code: Int, description: String) {
//        verificationCompletion?(.closeWithError(code: code, description: description))
//        self.responseDelegate?.onHumanVerifyEnd(result: .cancel)
//    }
//}

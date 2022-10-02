//
//  Container.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 9/26/22.
//

import Foundation
import TrustKit

final class Container {
    let login: Login
    let signupService: Signup

    private let api: PMAPIService
    //private let authManager: AuthManager
    //private var humanCheckHelper: HumanCheckHelper?
    let humanVerificationVersion: HumanVerificationVersion
    //private var paymentsManager: PaymentsManager?
    private let externalLinks: ExternalLinks
    private let clientApp: ClientApp
    private let appName: String
    //private let challenge: PMChallenge
    
    var token: String?
    var tokenType: String?

    init(appName: String,
         clientApp: ClientApp,
         doh: DoH & ServerConfig,
         apiServiceDelegate: APIServiceDelegate,
         //forceUpgradeDelegate: ForceUpgradeDelegate,
         humanVerificationVersion: HumanVerificationVersion,
         minimumAccountType: AccountType) {
        if PMAPIService.trustKit == nil {
            let trustKit = TrustKit()
            trustKit.pinningValidator = .init()
            PMAPIService.trustKit = trustKit
        }
        
        let sessionId = "LoginModuleSessionId"
        api = PMAPIService(doh: doh, sessionUID: sessionId)
        //api.forceUpgradeDelegate = forceUpgradeDelegate
        api.serviceDelegate = apiServiceDelegate
        //authManager = AuthManager()
        //api.authDelegate = authManager
        login = LoginService(api: api,
                             //authManager: authManager,
                             clientApp: clientApp,
                             sessionId: sessionId,
                             minimumAccountType: minimumAccountType)
        //challenge = PMChallenge()
        signupService = SignupService(api: api,
                                      //challangeParametersProvider:challenge,
                                      clientApp: clientApp)
        self.appName = appName
        self.clientApp = clientApp
        self.externalLinks = ExternalLinks(clientApp: clientApp)
        self.humanVerificationVersion = humanVerificationVersion
    }

    // MARK: Login view models

    func makeLoginViewModel() -> LoginViewModel {
       // challenge.reset()
        return LoginViewModel(login: login/*, challenge: challenge*/)
    }

//    func makeCreateAddressViewModel(username: String, data: CreateAddressData, updateUser: @escaping (User) -> Void) -> CreateAddressViewModel {
//        return CreateAddressViewModel(username: username, login: login, data: data, updateUser: updateUser)
//    }
//
//    func makeChooseUsernameViewModel(data: CreateAddressData) -> ChooseUsernameViewModel {
//        return ChooseUsernameViewModel(data: data, login: login, appName: appName)
//    }
//
//    func makeMailboxPasswordViewModel() -> MailboxPasswordViewModel {
//        return MailboxPasswordViewModel(login: login)
//    }
//
//    func makeTwoFactorViewModel() -> TwoFactorViewModel {
//        return TwoFactorViewModel(login: login)
//    }

    // MARK: Signup view models

    func makeSignupViewModel() -> SignupViewModel {
        //challenge.reset()
        return SignupViewModel(apiService: api,
                               signupService: signupService,
                               loginService: login,
                               //challenge: challenge,
                               humanVerificationVersion: humanVerificationVersion)
    }

//    func makePasswordViewModel() -> PasswordViewModel {
//        return PasswordViewModel()
//    }
//
//    func makeRecoveryViewModel(initialCountryCode: Int) -> RecoveryViewModel {
//        return RecoveryViewModel(signupService: signupService, initialCountryCode: initialCountryCode, challenge: challenge)
//    }
//
//    func makeCompleteViewModel(initDisplaySteps: [DisplayProgressStep]) -> CompleteViewModel {
//        return CompleteViewModel(signupService: signupService, loginService: login, initDisplaySteps: initDisplaySteps)
//    }
//
//    func makeEmailVerificationViewModel() -> EmailVerificationViewModel {
//        return EmailVerificationViewModel(apiService: api, signupService: signupService)
//    }
    
    func makeSummaryViewModel(planName: String?, screenVariant: SummaryScreenVariant) -> SummaryViewModel {
        return SummaryViewModel(planName: planName, screenVariant: screenVariant, clientApp: clientApp)
    }
    
//    func makePaymentsCoordinator(for iaps: ListOfIAPIdentifiers, shownPlanNames: ListOfShownPlanNames, reportBugAlertHandler: BugAlertHandler) -> PaymentsManager {
//        let paymentsManager = PaymentsManager(apiService: api, iaps: iaps, shownPlanNames: shownPlanNames, clientApp: clientApp, reportBugAlertHandler: reportBugAlertHandler)
//        self.paymentsManager = paymentsManager
//        return paymentsManager
//    }

    // MARK: Other view models

    func makeExternalLinks() -> ExternalLinks {
        return externalLinks
    }

//    func setupHumanVerification(viewController: UIViewController? = nil) {
//        let nonModalUrl = URL(string: "/users/availableExternal")!
//        humanCheckHelper = HumanCheckHelper(apiService: api,
//                                            viewController: viewController,
//                                            nonModalUrls: [nonModalUrl],
//                                            clientApp: clientApp,
//                                            versionToBeUsed: humanVerificationVersion,
//                                            responseDelegate: self,
//                                            paymentDelegate: self)
//        api.humanDelegate = humanCheckHelper
//    }

}

//extension Container: HumanVerifyPaymentDelegate {
//    var paymentToken: String? {
//        return paymentsManager?.tokenStorage?.get()?.token
//    }
//
//    func paymentTokenStatusChanged(status: PaymentTokenStatusResult) {
//
//    }
//}

extension Container: HumanVerifyResponseDelegate {
    func onHumanVerifyStart() { }
    
    func onHumanVerifyEnd(result: HumanVerifyEndResult) { }
    
    func humanVerifyToken(token: String?, tokenType: String?) {
        self.token = token
        self.tokenType = tokenType
    }
}

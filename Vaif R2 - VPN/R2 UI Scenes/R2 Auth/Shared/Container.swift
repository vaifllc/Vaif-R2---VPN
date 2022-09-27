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

//    private let api: PMAPIService
//    private let authManager: AuthManager
    private let externalLinks: ExternalLinks
    private let clientApp: ClientApp
    private let appName: String
    
    var token: String?
    var tokenType: String?

    init(appName: String,
         clientApp: ClientApp,
//         doh: DoH & ServerConfig,
//         apiServiceDelegate: APIServiceDelegate,
//         forceUpgradeDelegate: ForceUpgradeDelegate,
//         humanVerificationVersion: HumanVerificationVersion,
         minimumAccountType: AccountType) {
        
        let sessionId = "LoginModuleSessionId"
//        api = PMAPIService(doh: doh, sessionUID: sessionId)
//        api.forceUpgradeDelegate = forceUpgradeDelegate
//        api.serviceDelegate = apiServiceDelegate
//        authManager = AuthManager()
//        api.authDelegate = authManager
        login = LoginService( clientApp: clientApp, sessionId: sessionId, minimumAccountType: minimumAccountType)
        signupService = SignupService(clientApp: clientApp)
        self.appName = appName
        self.clientApp = clientApp
        self.externalLinks = ExternalLinks(clientApp: clientApp)
        //self.humanVerificationVersion = humanVerificationVersion
    }

    // MARK: Login view models

    func makeLoginViewModel() -> LoginViewModel {
        return LoginViewModel(login: login)
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
        return SignupViewModel(signupService: signupService,
                               loginService: login)
    }

//    func makePasswordViewModel() -> PasswordViewModel {
//        return PasswordViewModel()
//    }

//    func makeRecoveryViewModel(initialCountryCode: Int) -> RecoveryViewModel {
//        return RecoveryViewModel(signupService: signupService, initialCountryCode: initialCountryCode, challenge: challenge)
//    }

//    func makeCompleteViewModel(initDisplaySteps: [DisplayProgressStep]) -> CompleteViewModel {
//        return CompleteViewModel(signupService: signupService, loginService: login, initDisplaySteps: initDisplaySteps)
//    }

//    func makeEmailVerificationViewModel() -> EmailVerificationViewModel {
//        return EmailVerificationViewModel(apiService: api, signupService: signupService)
//    }
    
    func makeSummaryViewModel(planName: String?, screenVariant: SummaryScreenVariant) -> SummaryViewModel {
        return SummaryViewModel(planName: planName, screenVariant: screenVariant, clientApp: clientApp)
    }


    // MARK: Other view models

    func makeExternalLinks() -> ExternalLinks {
        return externalLinks
    }



}




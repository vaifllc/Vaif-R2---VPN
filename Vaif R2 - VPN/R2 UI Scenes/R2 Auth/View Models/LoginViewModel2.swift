//
//  LoginViewModel.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 9/26/22.
//

import Foundation
import PromiseKit
import CocoaLumberjackSwift

final class LoginViewModel {
    enum LoginResult {
        case done(LoginData)
        case twoFactorCodeNeeded
        case mailboxPasswordNeeded
        case createAddressNeeded(CreateAddressData)
    }
    
    // MARK: - Properties
    
    let finished = Publisher<LoginResult>()
    let error = Publisher<LoginError>()
    let isLoading = Observable<Bool>(false)
    static let accountStateDidChange = Notification.Name("AccountUIAccountStateDidChangeNotification")
    private var isBannerShown = false
    
    private let login: Login
    
    init(login: Login) {
        self.login = login
    }
    
    // MARK: - Actions
    
    func login(username: String, password: String) {
        isLoading.value = true
        
        firstly {
            try Client.signInWithEmail(email: username, password: password)
        }
        .done { (signin: SignIn) in
            try setAPICredentials(email: username, password: password)
            setAPICredentialsConfirmed(confirmed: true)
            self.isLoading.value = false
            NotificationCenter.default.post(name: LoginViewModel.accountStateDidChange, object: self)
            
            let banner = PMBanner(message: "Successful Login", style: PMBannerNewStyle.error, dismissDuration: Double.infinity)
            banner.addButton(text: CoreString._hv_ok_button) { _ in
                // logged in and confirmed - update this email with the receipt and refresh VPN credentials
                firstly { () -> Promise<SubscriptionEvent> in
                    try Client.subscriptionEvent()
                }
                .then { (result: SubscriptionEvent) -> Promise<GetKey> in
                    try Client.getKey()
                }
                .done { (getKey: GetKey) in
                    try setVPNCredentials(id: getKey.id, keyBase64: getKey.b64)
                    if (getUserWantsVPNEnabled() == true) {
                        VPNController.shared.restart()
                    }
                }
                .catch { error in
                    // it's okay for this to error out with "no subscription in receipt"
                    DDLogError("HomeViewController ConfirmEmail subscriptionevent error (ok for it to be \"no subscription in receipt\"): \(error)")
                }
                self.isBannerShown = false
                banner.dismiss()
            }
            banner.show(at: .topCustom(.baner), on: LoginViewController())
            self.isBannerShown = true

        }
        .catch { error in
            self.isLoading.value = false
            var errorMessage = error.localizedDescription
            if let apiError = error as? R2ApiError {
                errorMessage = apiError.message
            }
            
            let banner2 = PMBanner(message: "Error Signing In", style: PMBannerNewStyle.error, dismissDuration: Double.infinity)
            banner2.addButton(text: CoreString._hv_ok_button) { _ in
                self.isBannerShown = false
                banner2.dismiss()
            }
            banner2.show(at: .topCustom(.baner), on: LoginViewController())
            self.isBannerShown = true

        }
        
    }
    
    // MARK: - Validation
    
    func validate(username: String) -> Swift.Result<(), LoginValidationError> {
        return !username.isEmpty ? Swift.Result.success : Swift.Result.failure(LoginValidationError.emptyUsername)
    }
    
    func validate(password: String) -> Swift.Result<(), LoginValidationError> {
        return !password.isEmpty ? Swift.Result.success : Swift.Result.failure(LoginValidationError.emptyPassword)
    }
    
    func validate(cpassword: String) -> Swift.Result<(), LoginValidationError> {
        return !cpassword.isEmpty ? Swift.Result.success : Swift.Result.failure(LoginValidationError.emptyPassword)
    }
    
    func isValidEmail(email: String) -> Bool {
        guard !email.isEmpty else { return false }
        return email.isValidEmail()
    }
    
    func updateAvailableDomain(result: (([String]?) -> Void)? = nil) {
        login.updateAllAvailableDomains(type: .login) { res in result?(res) }
    }
    
}

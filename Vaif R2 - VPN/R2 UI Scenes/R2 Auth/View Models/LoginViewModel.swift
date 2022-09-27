//
//  LoginViewModel.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 9/26/22.
//

import Foundation


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

    private let login: Login

    init(login: Login) {
        self.login = login
    }

    // MARK: - Actions

    func login(username: String, password: String) {
       
        isLoading.value = true

        let userFrame = ["name": "username"]
            .first(where: { $0["frame"] as? [String: String] == userFrame })

        login.login(username: username, password: password) { [weak self] result in
            switch result {
            case let .failure(error):
                self?.error.publish(error)
                self?.isLoading.value = false
            case let .success(status):
                switch status {
                case let .finished(data):
                    self?.finished.publish(.done(data))
                case .ask2FA:
                    self?.finished.publish(.twoFactorCodeNeeded)
                    self?.isLoading.value = false
                case .askSecondPassword:
                    self?.finished.publish(.mailboxPasswordNeeded)
                    self?.isLoading.value = false
                case let .chooseInternalUsernameAndCreateInternalAddress(data):
                    self?.finished.publish(.createAddressNeeded(data))
                    self?.isLoading.value = false
                }
            }
        }
    }

    // MARK: - Validation

    func validate(username: String) -> Result<(), LoginValidationError> {
        return !username.isEmpty ? Result.success : Result.failure(LoginValidationError.emptyUsername)
    }

    func validate(password: String) -> Result<(), LoginValidationError> {
        return !password.isEmpty ? Result.success : Result.failure(LoginValidationError.emptyPassword)
    }

    func updateAvailableDomain(result: (([String]?) -> Void)? = nil) {
        login.updateAllAvailableDomains(type: .login) { res in result?(res) }
    }
}

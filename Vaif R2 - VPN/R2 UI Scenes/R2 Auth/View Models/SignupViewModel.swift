//
//  SignupViewModel.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 9/26/22.
//

import Foundation
import DeviceCheck


class SignupViewModel {

   // var apiService: PMAPIService
    var signupService: Signup
    var loginService: Login
    //let challenge: PMChallenge
   // let humanVerificationVersion: HumanVerificationVersion
    var currentlyChosenSignUpDomain: String {
        get { loginService.currentlyChosenSignUpDomain }
        set { loginService.currentlyChosenSignUpDomain = newValue }
    }
    var allSignUpDomains: [String] { loginService.allSignUpDomains }

    init(signupService: Signup,
         loginService: Login) {
        self.signupService = signupService
        self.loginService = loginService
    }

    func isUserNameValid(name: String) -> Bool {
        return !name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    func isEmailValid(email: String) -> Bool {
        guard !email.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else { return false }
        return email.isValidEmail()
    }

    func updateAvailableDomain(result: @escaping ([String]?) -> Void) {
        loginService.updateAllAvailableDomains(type: .signup, result: result)
    }

    func checkUsernameAccount(username: String, completion: @escaping (Result<(), AvailabilityError>) -> Void) {
        loginService.checkAvailabilityForUsernameAccount(username: username, completion: completion)
    }
    
//    func checkExternalEmailAccount(email: String, completion: @escaping (Result<(), AvailabilityError>) -> Void, editEmail: @escaping () -> Void) {
//        loginService.checkAvailabilityForExternalAccount(email: email) { result in
//            guard case .failure(let error) = result, error.codeInLogin == APIErrorCode.humanVerificationEditEmail else {
//                completion(result)
//                return
//            }
//            // transform internal HV error to editEmail closure
//            editEmail()
//        }
//    }
    
    func checkInternalAccount(username: String, completion: @escaping (Result<(), AvailabilityError>) -> Void) {
        loginService.checkAvailabilityForInternalAccount(username: username, completion: completion)
    }

    func requestValidationToken(email: String, completion: @escaping (Result<Void, SignupError>) -> Void) {
        signupService.requestValidationToken(email: email, completion: completion)
    }
}


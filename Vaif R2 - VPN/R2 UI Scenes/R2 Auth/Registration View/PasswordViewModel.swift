//
//  PasswordViewModel.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 10/12/22.
//

import Foundation


class PasswordViewModel {

    func passwordValidationResult(for restrictions: SignupPasswordRestrictions,
                                  password: String,
                                  repeatParrword: String) -> (Result<(), SignupError>) {

        let passwordFailedRestrictions = restrictions.failedRestrictions(for: password)
        let repeatPasswordFailedRestrictions = restrictions.failedRestrictions(for: repeatParrword)

        if passwordFailedRestrictions.contains(.notEmpty) && repeatPasswordFailedRestrictions.contains(.notEmpty) {
            return .failure(SignupError.passwordEmpty)
        }

        // inform the user
        if passwordFailedRestrictions.contains(.atLeastEightCharactersLong)
            && repeatPasswordFailedRestrictions.contains(.notEmpty) {
            return .failure(SignupError.passwordShouldHaveAtLeastEightCharacters)
        }

        guard password == repeatParrword else {
            return .failure(SignupError.passwordNotEqual)
        }

        if passwordFailedRestrictions.contains(.atLeastEightCharactersLong)
            && repeatPasswordFailedRestrictions.contains(.atLeastEightCharactersLong) {
            return .failure(SignupError.passwordShouldHaveAtLeastEightCharacters)
        }

        return .success
    }
}


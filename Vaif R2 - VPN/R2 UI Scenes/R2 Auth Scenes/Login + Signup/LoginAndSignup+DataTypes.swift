//
//  LoginAndSignup+DataTypes.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 9/22/22.
//

import Foundation


public enum SignupInitalMode {
    case `internal`
    case external
}

public enum LoginFeatureAvailability<Parameters> {
    case notAvailable
    case available(parameters: Parameters)
    
    public var isNotAvailable: Bool {
        if case .notAvailable = self { return true }
        return false
    }
}

public typealias SignupAvailability = LoginFeatureAvailability<SignupParameters>

public struct SignupParameters {
    
    let mode: SignupMode
    let separateDomainsButton: Bool
    let passwordRestrictions: SignupPasswordRestrictions
    let summaryScreenVariant: SummaryScreenVariant
    
    // No way to set signupMode because external email signup flow is temporarily turned off
    // until the updated flow is ready on the BE side
    init(_ separateDomainsButton: Bool,
         _ passwordRestrictions: SignupPasswordRestrictions,
         _ summaryScreenVariant: SummaryScreenVariant) {
        if let mode = TemporaryHacks.signupMode {
            self.mode = mode
        } else {
            self.mode = .internal
        }
        self.separateDomainsButton = separateDomainsButton
        self.passwordRestrictions = passwordRestrictions
        self.summaryScreenVariant = summaryScreenVariant
    }
}

public enum SignupMode: Equatable {
    case `internal`
    case external
    case both(initial: SignupInitalMode)
}

public struct SignupPasswordRestrictions: OptionSet {
    public let rawValue: Int
    public init(rawValue: Int) { self.rawValue = rawValue }

    public static let notEmpty                   = SignupPasswordRestrictions(rawValue: 1 << 0)
    public static let atLeastEightCharactersLong = SignupPasswordRestrictions(rawValue: 1 << 1)

    public static let `default`: SignupPasswordRestrictions = [.atLeastEightCharactersLong, .notEmpty]

    public func failedRestrictions(for password: String) -> SignupPasswordRestrictions {
        var failedRestrictions: SignupPasswordRestrictions = []
        if contains(.notEmpty) && password.isEmpty {
            failedRestrictions.insert(.notEmpty)
        }
        if contains(.atLeastEightCharactersLong) && password.count < 8 {
            failedRestrictions.insert(.atLeastEightCharactersLong)
        }
        return failedRestrictions
    }
}

public typealias PaymentsAvailability = LoginFeatureAvailability<PaymentsParameters>

public struct PaymentsParameters {
    
    let listOfIAPIdentifiers: ListOfIAPIdentifiers
    let listOfShownPlanNames: ListOfShownPlanNames
    var reportBugAlertHandler: BugAlertHandler
    
    public init(listOfIAPIdentifiers: ListOfIAPIdentifiers, listOfShownPlanNames: ListOfShownPlanNames, reportBugAlertHandler: BugAlertHandler) {
        self.listOfIAPIdentifiers = listOfIAPIdentifiers
        self.listOfShownPlanNames = listOfShownPlanNames
        self.reportBugAlertHandler = reportBugAlertHandler
    }
}


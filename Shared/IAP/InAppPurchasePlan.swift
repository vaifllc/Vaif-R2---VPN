//
//  InAppPurchasePlan.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 9/22/22.
//

import Foundation

public typealias ListOfIAPIdentifiers = Set<String>
public typealias ListOfShownPlanNames = Set<String>

@available(*, deprecated, renamed: "InAppPurchasePlan")
public typealias AccountPlan = InAppPurchasePlan

public struct InAppPurchasePlan: Equatable, Hashable {

    public typealias ProductId = String

    public let protonName: String
    public let storeKitProductId: ProductId?
    public let period: String?

    public var isFreePlan: Bool { InAppPurchasePlan.isThisAFreePlan(protonName: protonName) }

    public static let freePlanName = "free"

    public static func isThisAFreePlan(protonName: String) -> Bool {
        protonName == freePlanName || protonName == "vpnfree" || protonName == "drivefree"
    }

    public static func isThisATrialPlan(protonName: String) -> Bool {
        protonName == "trial"
    }

    private static let regex: NSRegularExpression = {
        guard let instance = try? NSRegularExpression(pattern: "^ios.*_(.*)_(\\d+)_\\w+_non_renewing$", options: [.anchorsMatchLines]) else {
            assertionFailure("The regular expression was not compiled right")
            return NSRegularExpression()
        }
        return instance
    }()

    public static func protonNameAndPeriod(from storeKitProductId: ProductId) -> (String, String)? {
        guard let result = regex.firstMatch(in: storeKitProductId, options: [], range: NSRange(location: 0, length: storeKitProductId.count)),
              result.numberOfRanges == 3,
              result.range(at: 1).location != NSNotFound,
              result.range(at: 1).length != 0,
              result.range(at: 2).location != NSNotFound,
              result.range(at: 2).length != 0
        else { return nil }
        let protonName = NSString(string: storeKitProductId).substring(with: result.range(at: 1))
        let period = NSString(string: storeKitProductId).substring(with: result.range(at: 2))
        return (protonName, period)
    }

    public static func nameIsPresentInIAPIdentifierList(name: String, identifiers: ListOfIAPIdentifiers) -> Bool {
        InAppPurchasePlan(protonName: name, listOfIAPIdentifiers: identifiers)?.storeKitProductId != nil
    }
    
    public static func nameAndCycleArePresentInIAPIdentifierList(name: String, cycle: Int?, identifiers: ListOfIAPIdentifiers) -> Bool {
        guard let iapPlan = InAppPurchasePlan(protonName: name, listOfIAPIdentifiers: identifiers) else { return false }
        return iapPlan.storeKitProductId != nil && iapPlan.period == cycle.map(String.init)
    }

    public init?(protonName: String, listOfIAPIdentifiers: ListOfIAPIdentifiers) {
        guard !protonName.isEmpty else { return nil }
        self.init(protonPlanName: protonName, listOfIAPIdentifiers: listOfIAPIdentifiers)
    }

    private init(protonPlanName: String, listOfIAPIdentifiers: ListOfIAPIdentifiers) {
        self.protonName = protonPlanName
        let extractedData = zip(listOfIAPIdentifiers, listOfIAPIdentifiers.map(InAppPurchasePlan.protonNameAndPeriod(from:)))
            .map { (storeKitProductId: $0.0, extractedProtonName: $0.1) }
            .first { _, extractedProtonName in extractedProtonName?.0 == protonPlanName }
            .map { ($0, $1?.1) }
        self.storeKitProductId = extractedData?.0
        self.period = extractedData?.1
    }

    public init?(storeKitProductId: ProductId) {
        guard let extractedData = InAppPurchasePlan.protonNameAndPeriod(from: storeKitProductId) else { return nil }
        self.storeKitProductId = storeKitProductId
        self.protonName = extractedData.0
        self.period = extractedData.1
    }
}


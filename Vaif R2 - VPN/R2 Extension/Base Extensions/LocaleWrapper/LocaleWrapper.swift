//
//  LocaleWrapper.swift
//  VaifR2
//
//  Created by VAIF on 1/7/23.
//

import Foundation

public protocol LocaleResolver {
    var preferredLanguages: [String] { get }
    var currentLocale: LocaleWrapper { get }

    func locale(withIdentifier: String) -> LocaleWrapper
}

public protocol LocaleWrapper {
    func localizedString(forRegionCode: String) -> String?
}

public class LocaleResolverImplementation: LocaleResolver {
    public var preferredLanguages: [String] {
        Locale.preferredLanguages
    }

    public var currentLocale: LocaleWrapper {
        Locale.current
    }

    public func locale(withIdentifier identifier: String) -> LocaleWrapper {
        Locale(identifier: identifier)
    }
}

extension Locale: LocaleWrapper {
}


//
//  BasicFixtures.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 10/9/22.
//

import Foundation

public enum Dummy {
    public static let domain = "protoncore.unittest"
    public static let url = "https://\(domain)"
    public static let apiPath = "/unittest/api"
}

public extension String {
    static var empty: String { "" }
}

public extension Array {
    static var empty: Array { [] }
}

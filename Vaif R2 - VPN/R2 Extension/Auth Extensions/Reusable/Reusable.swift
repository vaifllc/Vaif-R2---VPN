//
//  Reusable.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 9/26/22.
//

protocol Reusable: AnyObject {
    static var reuseIdentifier: String { get }
}

extension Reusable {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}


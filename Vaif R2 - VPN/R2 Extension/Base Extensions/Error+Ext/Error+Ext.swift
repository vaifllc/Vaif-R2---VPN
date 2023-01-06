//
//  Error+Ext.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 1/3/23.
//

import Foundation

extension Error {
    var code: Int { return (self as NSError).code }
}

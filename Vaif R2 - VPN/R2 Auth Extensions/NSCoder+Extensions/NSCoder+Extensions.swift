//
//  NSCoder+Extensions.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 9/22/22.
//

import Foundation

extension NSCoder {
    
    @available(*, deprecated, renamed: "string(forKey:)")
    public func decodeStringForKey(_ key: String) -> String? {
        return decodeObject(forKey: key) as? String
    }
    
    public func string(forKey key: String) -> String? {
        return decodeObject(forKey: key) as? String
    }
}


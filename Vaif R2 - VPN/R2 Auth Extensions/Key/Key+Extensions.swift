//
//  Key+Extensions.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 9/22/22.
//

import Foundation

extension Array where Element: Key {
    func archive() -> Data {
        return NSKeyedArchiver.archivedData(withRootObject: self)
    }
    
    @available(*, deprecated, renamed: "isKeyV2")
    internal var newSchema: Bool {
        for key in self where key.newSchema {
            return true
        }
        return false
    }
    
    public var isKeyV2: Bool {
        for key in self where key.isKeyV2 {
            return true
        }
        return false
    }
    
}


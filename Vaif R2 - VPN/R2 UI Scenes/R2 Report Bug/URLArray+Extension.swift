//
//  URLArray+Extension.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 9/30/22.
//

import Foundation


extension Array where Element == URL {
    
    /// Only reachable URLs
    public func reachable() -> Self {
        return self.compactMap { (try? $0.checkPromisedItemIsReachable()) ?? false ? $0 : nil }
    }
    
}

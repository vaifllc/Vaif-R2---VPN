//
//  NSError+Extension.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 9/28/22.
//

import Foundation

extension NSError {
    
    public class var protonVpnErrorDomain: String {
        return "ch.protonvpn.error"
    }
    
    public convenience init(domain: String? = nil, code: Int, localizedDescription: String) {
        let errorDomain = domain != nil ? domain! : NSError.protonVpnErrorDomain
        let userInfo: [String: String] = [NSLocalizedDescriptionKey: localizedDescription]
        self.init(domain: errorDomain, code: code, userInfo: userInfo)
    }
}


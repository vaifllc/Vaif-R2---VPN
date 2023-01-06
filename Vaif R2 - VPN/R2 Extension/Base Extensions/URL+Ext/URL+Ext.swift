//
//  URL+Ext.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 1/3/23.
//

import Foundation

extension URL {
    
    func getTopLevelSubdomain() -> String {
        if let hostName = host {
            let subStrings = hostName.components(separatedBy: ".")
            var domainName = ""
            let count = subStrings.count
            
            if count > 2 {
                domainName = subStrings[count - 3] + "." + subStrings[count - 2] + "." + subStrings[count - 1]
            } else if count <= 2 {
                domainName = hostName
            }
            
            return domainName
        }
        
        return ""
    }
    
}

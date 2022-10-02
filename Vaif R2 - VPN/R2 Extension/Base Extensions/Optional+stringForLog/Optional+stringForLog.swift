//
//  Optional+stringForLog.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 9/28/22.
//

import Foundation

extension Optional where Wrapped: Any {
    
    /// Removes 'Optional' from the string and decodes Data to String.
    var stringForLog: String {
        guard let value = self else {
            return "null"
        }
        
        switch value {
        case let dataValue as Data:
            return String(data: dataValue, encoding: .utf8) ?? "-"
        default:
            return "\(value)"
        }
    }
}


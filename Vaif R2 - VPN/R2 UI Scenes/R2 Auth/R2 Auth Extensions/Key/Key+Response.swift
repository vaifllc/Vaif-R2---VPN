//
//  Key+Response.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 9/22/22.
//

import Foundation

extension Key {
    
    /// Initializes the Key with the response data [String:Any]
    public convenience init(response: [String: Any]) {
        self.init(keyID: response["ID"] as? String ?? "",
                  privateKey: response["PrivateKey"] as? String,
                  token: response["Token"] as? String,
                  signature: response["Signature"] as? String,
                  activation: response["Activation"] as? String)
    }
}


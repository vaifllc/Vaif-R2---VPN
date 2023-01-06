//
//  AccessDetails.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 1/3/23.
//

import Foundation

class AccessDetails {
    
    var serverAddress: String
    var ipAddresses: [String]
    var username: String
    var passwordRef: Data?
    
    init(serverAddress: String, ipAddresses: [String], username: String, passwordRef: Data?) {
        self.serverAddress = serverAddress
        self.ipAddresses = ipAddresses
        self.username = username
        self.passwordRef = passwordRef
    }
    
}

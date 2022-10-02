//
//  CustomServerConfigDoH.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 9/29/22.
//

import Foundation


public final class CustomServerConfigDoH: DoH, ServerConfig {
    public let signupDomain: String
    public let captchaHost: String
    public let humanVerificationV3Host: String
    public let accountHost: String
    public let defaultHost: String
    public let apiHost: String
    public let defaultPath: String
    
    public init(signupDomain: String,
                captchaHost: String,
                humanVerificationV3Host: String,
                accountHost: String,
                defaultHost: String,
                apiHost: String,
                defaultPath: String) {
        self.signupDomain = signupDomain
        self.captchaHost = captchaHost
        self.humanVerificationV3Host = humanVerificationV3Host
        self.accountHost = accountHost
        self.defaultHost = defaultHost
        self.apiHost = apiHost
        self.defaultPath = defaultPath
        super.init()
    }
}

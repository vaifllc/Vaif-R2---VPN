//
//  ExternalLinks.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 9/26/22.
//

import Foundation

final class ExternalLinks {
    
    let clientApp: ClientApp
    
    init(clientApp: ClientApp) {
        self.clientApp = clientApp
    }
 
    var passwordReset: URL {
        switch clientApp {
        case .vpn:
            return URL(string: "https://account.protonvpn.com/reset-password")!
        default:
            return URL(string: "https://mail.protonmail.com/help/reset-login-password")!
        }
    }
    
    var accountSetup: URL {
        switch clientApp {
        case .vpn:
            return URL(string: "https://account.protonvpn.com/")!
        default:
            return URL(string: "https://account.protonmail.com/")!
        }
    }
    
    var termsAndConditions: URL {
        switch clientApp {
        case .vpn:
            return URL(string: "https://protonvpn.com/ios-terms-and-conditions.html")!
        default:
            return URL(string: "https://protonmail.com/ios-terms-and-conditions.html")!
        }
    }
    
    var support: URL {
        switch clientApp {
        case .vpn:
            return URL(string: "https://protonvpn.com/support")!
        default:
            return URL(string: "https://protonmail.com/support-form")!
        }
    }
    
    var commonLoginProblems: URL {
        switch clientApp {
        case .vpn:
            return URL(string: "https://protonvpn.com/support/login-problems")!
        default:
            return URL(string: "https://protonmail.com/support/knowledge-base/common-login-problems")!
        }
    }
    
    var forgottenUsername: URL {
        switch clientApp {
        case .vpn:
            return URL(string: "https://account.protonvpn.com/forgot-username")!
        default:
            return URL(string: "https://protonmail.com/username")!
        }
    }
}


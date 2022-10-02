//
//  SafariService.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 9/28/22.
//

import Foundation
#if canImport(UIKit)
import UIKit
#elseif canImport(Cocoa)
import Cocoa
#endif

public protocol SafariServiceProtocol {
    func open(url: String)
}

public protocol SafariServiceFactory {
    func makeSafariService() -> SafariServiceProtocol
}

public class SafariService: SafariServiceProtocol {
    
    // Old
    public static func openLink(url: String) {
        guard let url = URL(string: url) else {
            return
        }
        #if canImport(UIKit)
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
        #elseif canImport(Cocoa)
        NSWorkspace.shared.open(url)
        #endif
    }
    
    // Use this one in new code
    public func open(url: String) {
        SafariService.openLink(url: url)
    }
    
    public init() {
    }
}

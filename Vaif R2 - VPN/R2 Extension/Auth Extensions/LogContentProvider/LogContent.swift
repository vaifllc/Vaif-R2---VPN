//
//  LogContent.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 9/30/22.
//

import Foundation


/// Classes implementing this protocol can provide logs from various sources like reading from files, `os_log` subsystem or network extensions.
public protocol LogContent {
    func loadContent(callback: @escaping (String) -> Void)
}

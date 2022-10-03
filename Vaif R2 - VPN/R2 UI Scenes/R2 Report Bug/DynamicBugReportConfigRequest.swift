//
//  DynamicBugReportConfigRequest.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 10/3/22.
//

import Foundation


class DynamicBugReportConfigRequest: Request {
    var path: String {
        return "/vpn/featureconfig/dynamic-bug-reports"
    }

    var isAuth: Bool {
        return false
    }
}

//
//  StatusRequest.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 9/22/22.
//

import Foundation


final class StatusRequest: BaseApiRequest<StatusResponse> {

    override var path: String { super.path + "/v4/status" }

    override var isAuth: Bool { false }
}

final class StatusResponse: Response {
    var isAvailable: Bool?

    override func ParseResponse(_ response: [String: Any]!) -> Bool {
        PMLog.debug(response.json(prettyPrinted: true))
        self.isAvailable = response["Apple"] as? Bool
        return true
    }
}


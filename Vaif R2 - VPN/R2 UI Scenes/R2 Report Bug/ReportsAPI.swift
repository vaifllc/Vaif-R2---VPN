//
//  ReportsAPI.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 9/30/22.
//

import Foundation


public struct ReportBug {
    
    public let os: String // iOS, MacOS
    public let osVersion: String
    public let client: String
    public let clientVersion: String
    public let clientType: Int // 1 = email, 2 = VPN
    public var title: String
    public var description: String
    public let username: String
    public var email: String
    public var country: String
    public var ISP: String
   // public var plan: String
    public var files = [URL]() // Param names: File0, File1, File2...
    
    public init(os: String, osVersion: String, client: String, clientVersion: String, clientType: Int, title: String, description: String, username: String, email: String, country: String, ISP: String/*, plan: String*/) {
        self.os = os
        self.osVersion = osVersion
        self.client = client
        self.clientVersion = clientVersion
        self.clientType = clientType
        self.title = title
        self.description = description
        self.username = username
        self.email = email
        self.country = country
        self.ISP = ISP
        //self.plan = plan
    }
    
    public var canBeSent: Bool {
        return !description.isEmpty && !email.isEmpty
    }
}

public struct ReportsBugsResponse: Codable {
    let code: Int
}

public final class ReportsBugs: Request {
    
    public let bug: ReportBug
    
    public init( _ bug: ReportBug) {
        self.bug = bug
    }

    public var path: String {
        return "/reports/bug"
    }

    public var method: HTTPMethod {
        return .post
    }

    public var parameters: [String: Any]? {
        return [
            "OS": bug.os,
            "OSVersion": bug.osVersion,
            "Client": bug.client,
            "ClientVersion": bug.clientVersion,
            "ClientType": String(bug.clientType),
            "Title": bug.title,
            "Description": bug.description,
            "Username": bug.username,
            "Email": bug.email,
            "Country": bug.country,
            "ISP": bug.ISP
            //"Plan": bug.plan
        ]
    }
    
    var auth: AuthCredential?
    public var authCredential: AuthCredential? {
        return self.auth
    }
}

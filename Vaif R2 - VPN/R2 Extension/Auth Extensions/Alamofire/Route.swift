//
//  Route.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 9/26/22.
//

import Foundation


public protocol Package {
    /**
     conver requset object to dictionary
     
     :returns: request dictionary
     */
    var parameters: [String: Any]? { get }
}

///
public enum HTTPMethod2 {
    case delete
    case get
    case post
    case put

    public func toString() -> String {
        switch self {
        case .delete:
            return "DELETE"
        case .get:
            return "GET"
        case .post:
            return "POST"
        case .put:
            return "PUT"
        }
    }
}

// APIClient is the api client base
public protocol Request: Package {
    // those functions shdould be overrided
    var path: String { get }
    var header: [String: Any] { get }
    var method: HTTPMethod2 { get }
    var nonDefaultTimeout: TimeInterval? { get }

    var isAuth: Bool { get }

   // var authCredential: AuthCredential? { get }
    var autoRetry: Bool { get }
}

extension Request {
    public var isAuth: Bool {
        return true
    }

    public var autoRetry: Bool {
        return true
    }

    public var header: [String: Any] {
        return [:]
    }

    public var authCredential: AuthCredential? {
        return nil
    }

    public var method: HTTPMethod2 {
        return .get
    }

    public var parameters: [String: Any]? {
        return nil
    }
    
    public var nonDefaultTimeout: TimeInterval? {
        return nil
    }
}

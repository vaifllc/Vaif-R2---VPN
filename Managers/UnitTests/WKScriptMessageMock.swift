//
//  WKScriptMessageMock.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 10/9/22.
//

import WebKit

public final class WKScriptMessageMock: WKScriptMessage {
    
    public var intName: String
    public var intBody: Any
    
    public init(name: String, body: Any) {
        self.intName = name
        self.intBody = body
    }
    
    override public var name: String {
        get {
            return intName
        }
        set {
            intName = newValue
        }
    }
    
    override public var body: Any {
        get {
            return intBody
        }
        set {
            intBody = newValue
        }
    }
}

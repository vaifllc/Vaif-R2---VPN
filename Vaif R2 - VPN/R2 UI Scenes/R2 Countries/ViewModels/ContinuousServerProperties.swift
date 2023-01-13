//
//  ContinuousServerProperties.swift
//  VaifR2
//
//  Created by VAIF on 1/7/23.
//

import Foundation

public typealias ContinuousServerPropertiesDictionary = [String: ContinuousServerProperties]

public class ContinuousServerProperties: NSObject {
    
    public let serverId: String
    public let load: Int
    public let score: Double
    public let status: Int
    
    override public var description: String {
        return
            "ServerID: \(serverId)\n" +
            "Load: \(load)\n" +
            "Score: \(score)\n" +
            "Status: \(status)"
    }
    
    public init(serverId: String, load: Int, score: Double, status: Int) {
        self.serverId = serverId
        self.load = load
        self.score = score
        self.status = status
        super.init()
    }
    
    public init(dic: JSONDictionary) throws {
        serverId = try dic.stringOrThrow(key: "ID") // "ID": "ABC"
        load = try dic.intOrThrow(key: "Load") // "Load": "15"
        score = try dic.doubleOrThrow(key: "Score") // "Score": "1.4454542"
        status = try dic.intOrThrow(key: "Status") // "Status": 1
        super.init()
    }

    var asDict: [String: Any] {
        [
            "ID": serverId,
            "Load": load,
            "Score": score,
            "Status": status,
        ]
    }
}


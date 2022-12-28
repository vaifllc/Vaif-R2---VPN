//
//  Codable+Ergonomics.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 10/9/22.
//

import Foundation

public extension Encodable {
    var toJsonDict: [String: Any] {
        try! JSONSerialization.jsonObject(with: JSONEncoder().encode(self)) as! [String: Any]
    }

    var toSuccessfulResponse: [String: Any] {
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .custom({ codingPath in
            let lastKey = codingPath.last!
            if lastKey.intValue != nil {
                return lastKey
            }
            var exceptionKey: String?
            encodingStrategyExceptions.forEach {
                if lastKey.stringValue == $0.key {
                    exceptionKey = $0.value
                }
            }
            if let exceptionKey = exceptionKey {
                return CustomCodingKey(stringValue: exceptionKey)!
            }
            let firstLetter = lastKey.stringValue.prefix(1).uppercased()
            let modifiedKey = firstLetter + lastKey.stringValue.dropFirst()
            return CustomCodingKey(stringValue: modifiedKey)!
        })

        var result = try! JSONSerialization.jsonObject(with: encoder.encode(self)) as! [String: Any]
        result["Code"] = 1000
        return result
    }
    
    func toErrorResponse(code: Int, error: String) -> [String: Any] {
        var result = try! JSONSerialization.jsonObject(with: JSONEncoder().encode(self)) as! [String: Any]
        result["Code"] = code
        result["Error"] = error
        return result
    }
    
    var encodingStrategyExceptions: [String: String] {
        return ["srpSession": "SRPSession"]
    }

    func toSuccessfulResponse(underKey key: String) -> [String: Any] {
        var result: [String: Any] = [:]
        result[key] = try! JSONSerialization.jsonObject(with: JSONEncoder().encode(self))
        result["Code"] = 1000
        return result
    }
}

public extension Decodable {
    func from(_ dict: [String: Any]?) -> Self {
        try! JSONDecoder().decode(Self.self, from: JSONSerialization.data(withJSONObject: dict!))
    }
}

struct CustomCodingKey: CodingKey {
    var stringValue: String
    
    init?(stringValue: String) {
        self.stringValue = stringValue
    }

    var intValue: Int? {
        return nil
    }
    
    init?(intValue: Int) {
        return nil
    }
}


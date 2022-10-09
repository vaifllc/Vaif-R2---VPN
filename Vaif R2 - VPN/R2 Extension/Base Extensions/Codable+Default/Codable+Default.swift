//
//  Codable+Default.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 10/8/22.
//

import Foundation

public protocol DefaultValue {
    associatedtype Value: Codable
    static var defaultValue: Value { get }
}

extension Bool: DefaultValue {
    public static let defaultValue = false
}

@propertyWrapper
public struct Default<T: DefaultValue> {
    public var wrappedValue: T.Value

    public init(wrappedValue: T.Value) {
        self.wrappedValue = wrappedValue
    }
}

extension Default: Decodable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        wrappedValue = (try? container.decode(T.Value.self)) ?? T.defaultValue
    }
}

extension Default: Encodable {
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(wrappedValue)
    }
}

public extension KeyedDecodingContainer {
    func decode<T>(_ type: Default<T>.Type, forKey key: Key) throws -> Default<T> where T: DefaultValue {
        try decodeIfPresent(type, forKey: key) ?? Default(wrappedValue: T.defaultValue)
    }
}


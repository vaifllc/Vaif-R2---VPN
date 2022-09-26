//
//  KeyedDecodingContainer+DecodeBoolFromInt.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 9/26/22.
//

import Foundation

extension KeyedDecodingContainer {
    
    /// Decodes a boolean from an integer for the given key.
    ///
    /// - parameter key: The key that the decoded value is associated with.
    /// - returns: A boolean, if present for the given key and convertible to the requested type.
    /// - throws: `DecodingError.dataCorrupted` if the encountered encoded value
    ///   is different than 0 or 1.
    /// - throws: `DecodingError.typeMismatch` if the encountered encoded value
    ///   is not convertible to the Integer type.
    /// - throws: `DecodingError.keyNotFound` if `self` does not have an entry
    ///   for the given key.
    /// - throws: `DecodingError.valueNotFound` if `self` has a null entry for
    ///   the given key.
    public func decodeBoolFromInt(forKey key: KeyedDecodingContainer<K>.Key) throws -> Bool {
        let integer = try decode(Int.self, forKey: key)
        let boolValue: Bool
        switch integer {
        case 0:
            boolValue = false
        case 1:
            boolValue = true
        default:
            let errorDescription = "Expected to receive `0` or `1` but found `\(integer)` instead."
            throw DecodingError.dataCorruptedError(forKey: key, in: self, debugDescription: errorDescription)
        }
        
        return boolValue
    }
    
}


//
//  FileHandler+New.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 10/9/22.
//

import Foundation

// Extension to use updated methonds on OSes that support them
extension FileHandle {
    public func seekToEndCustom() throws -> UInt64 {
        if #available(macOS 10.15.4, iOS 13.4, tvOS 13.4, watchOS 6.2, *) {
            return try seekToEnd()
        } else {
            return seekToEndOfFile()
        }
    }
    
    public func writeCustom(contentsOf data: Data) throws {
        if #available(macOS 10.15.4, iOS 13.4, tvOS 13.4, watchOS 6.2, *) {
            try write(contentsOf: data)
        } else {
            write(data)
        }
    }
    
    public func synchronizeCustom() throws {
        if #available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *) {
            try synchronize()
        } else {
            synchronizeFile()
        }
    }
    
    public func closeCustom() throws {
        if #available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *) {
            try close()
        } else {
            closeFile()
        }
    }
}


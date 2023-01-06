//
//  Data+Ext.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 1/3/23.
//

import Foundation
import WireGuardKitC

extension Data {
    
    func withUnsafeUInt8Bytes<R>(_ body: (UnsafePointer<UInt8>) -> R) -> R {
        return self.withUnsafeBytes { (ptr: UnsafeRawBufferPointer) -> R in
            let bytes = ptr.bindMemory(to: UInt8.self)
            return body(bytes.baseAddress!) // might crash if self.count == 0
        }
    }
    
    mutating func withUnsafeMutableUInt8Bytes<R>(_ body: (UnsafeMutablePointer<UInt8>) -> R) -> R {
        return self.withUnsafeMutableBytes { (ptr: UnsafeMutableRawBufferPointer) -> R in
            let bytes = ptr.bindMemory(to: UInt8.self)
            return body(bytes.baseAddress!) // might crash if self.count == 0
        }
    }
    
}


//
//  FileHandleWrapper.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 10/9/22.
//

import Foundation

/// Wraps `FileHandle` to show what methods we are using and make it possible to mock them in tests
public protocol FileHandleWrapper {
    init(forWritingTo url: URL) throws
    func seekToEndCustom() throws -> UInt64
    func writeCustom(contentsOf data: Data) throws
    func synchronizeCustom() throws
    func closeCustom() throws
}

extension FileHandle: FileHandleWrapper {
}


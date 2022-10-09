//
//  FileHandleMock.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 10/9/22.
//

import Foundation
import SwiftOnoneSupport
import UIKit
import WebKit
import XCTest
import _Concurrency
import _StringProcessing

class FileHandleMock: FileHandleWrapper {

    public let url: URL

    required init(forWritingTo url: URL) throws {
        self.url = url
    }

    @ThrowingFuncStub(FileHandleWrapper.seekToEndCustom, initialReturn: 0) var seekToEndCustomStub
    func seekToEndCustom() throws -> UInt64 {
        try seekToEndCustomStub()
    }

    @ThrowingFuncStub(FileHandleWrapper.writeCustom) var writeCustomStub
    func writeCustom(contentsOf data: Data) throws {
        try writeCustomStub(data)
    }

    @ThrowingFuncStub(FileHandleWrapper.synchronizeCustom) var synchronizeCustomStub
    func synchronizeCustom() throws {
        try synchronizeCustomStub()
    }

    @ThrowingFuncStub(FileHandleWrapper.closeCustom) var closeCustomStub
    func closeCustom() throws {
        try closeCustomStub()
    }
}


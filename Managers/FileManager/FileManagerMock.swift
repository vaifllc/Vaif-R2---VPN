//
//  FileManagerMock.swift
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

class FileManagerMock: FileManagerWrapper {

    @ThrowingFuncStub(FileManagerMock.createDirectory)  var createDirectoryStub
    func createDirectory(at url: URL, withIntermediateDirectories createIntermediates: Bool, attributes: [FileAttributeKey: Any]?) throws {
        try createDirectoryStub(url, createIntermediates, attributes)
    }

    @FuncStub(FileManagerMock.fileExists, initialReturn: false) var fileExistsStub
    func fileExists(atPath path: String) -> Bool {
        fileExistsStub(path)
    }

    @FuncStub(FileManagerMock.createFile, initialReturn: true) var createFileStub
    func createFile(atPath path: String, contents data: Data?, attributes attr: [FileAttributeKey: Any]?) -> Bool {
        createFileStub(path, data, attr)
    }

    @ThrowingFuncStub(FileManagerMock.moveItem) var moveItemStub
    func moveItem(at srcURL: URL, to dstURL: URL) throws {
        try moveItemStub(srcURL, dstURL)
    }

    @ThrowingFuncStub(FileManagerMock.contentsOfDirectory, initialReturn: []) var contentsOfDirectoryStub
    func contentsOfDirectory(at url: URL, includingPropertiesForKeys keys: [URLResourceKey]?, options mask: FileManager.DirectoryEnumerationOptions) throws -> [URL] {
        try contentsOfDirectoryStub(url, keys, mask)
    }

    @ThrowingFuncStub(FileManagerMock.attributesOfItem, initialReturn: [:]) var attributesOfItemStub
    func attributesOfItem(atPath path: String) throws -> [FileAttributeKey: Any] {
        try attributesOfItemStub(path)
    }

    @ThrowingFuncStub(FileManagerMock.removeItem) var removeItemStub
    func removeItem(at URL: URL) throws {
        try removeItemStub(URL)
    }

    @ThrowingFuncStub(FileManagerMock.createFileHandle, initialReturn: try FileHandleMock(forWritingTo: URL(string: "/file")!)) var createFileHandleStub
    public func createFileHandle(forWritingTo url: URL) throws -> FileHandleWrapper {
        return try createFileHandleStub(url)
    }
}

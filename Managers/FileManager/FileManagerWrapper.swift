//
//  FileManagerWrapper.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 10/9/22.
//

import Foundation

/// Wraps `FileManager` to show what methods we are using and make it possible to mock them in tests
public protocol FileManagerWrapper {

    // Methods from FileManager
    func createDirectory(at url: URL, withIntermediateDirectories createIntermediates: Bool, attributes: [FileAttributeKey: Any]?) throws
    func fileExists(atPath path: String) -> Bool
    @discardableResult func createFile(atPath path: String, contents data: Data?, attributes attr: [FileAttributeKey: Any]?) -> Bool
    func moveItem(at srcURL: URL, to dstURL: URL) throws
    func contentsOfDirectory(at url: URL, includingPropertiesForKeys keys: [URLResourceKey]?, options mask: FileManager.DirectoryEnumerationOptions) throws -> [URL]
    func attributesOfItem(atPath path: String) throws -> [FileAttributeKey: Any]
    func removeItem(at URL: URL) throws

    // Custom methods

    // Lets us use `FileHandleWrapper` instead of `FileHandler` directly, so it can also be mocked.
    func createFileHandle(forWritingTo url: URL) throws -> FileHandleWrapper
}

extension FileManager: FileManagerWrapper {
    public func createFileHandle(forWritingTo url: URL) throws -> FileHandleWrapper {
        return try FileHandle(forWritingTo: url)
    }
}


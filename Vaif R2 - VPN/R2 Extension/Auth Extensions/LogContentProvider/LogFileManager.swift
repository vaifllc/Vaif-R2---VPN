//
//  LogFileManager.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 10/2/22.
//

import Foundation


public protocol LogFileManagerFactory {
    func makeLogFileManager() -> LogFileManager
}

public protocol LogFileManager {
    func getFileUrl(named filename: String) -> URL
    func dump(logs: String, toFile filename: String)
}

public class LogFileManagerImplementation: LogFileManager {
    
    public init() {
    }
    
    /// Returns full log files URL given its name
    public func getFileUrl(named filename: String) -> URL {
        return FileManager.default.urls(for: .libraryDirectory, in: .userDomainMask).first!
            .appendingPathComponent("Logs", isDirectory: true)
            .appendingPathComponent(filename, isDirectory: false)
    }
    
    /// Dumps given string into a log file.
    /// Will overwrite the file if it's present.
    public func dump(logs: String, toFile filename: String) {
        let logPath = getFileUrl(named: filename)
        do {
            try "\(logs)".data(using: .utf8)?.write(to: logPath)
        } catch {
            print("Error dumping logs to file: \(error)")
            //log.error("Error dumping logs to file: \(error)")
        }
    }
    
}

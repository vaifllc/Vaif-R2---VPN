//
//  FileLogContent.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 9/30/22.
//

import Foundation

/// Reads and returns content of log file
class FileLogContent: LogContent {

    private let file: URL

    init(file: URL) {
        self.file = file
    }

    func loadContent(callback: @escaping (String) -> Void) {
        DispatchQueue.global(qos: .userInitiated).async {
            let contents = try? String(contentsOf: self.file)
            callback(contents ?? "")
        }
    }

}

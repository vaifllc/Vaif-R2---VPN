//
//  AppLogContent.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 9/30/22.
//

import Foundation


/// App logs can be split into several files. This class collects logs from all of them.
public class AppLogContent: LogContent {

    private let folder: URL
    private let filenameWithoutExtension: String = "ProtonVPN"

    init(folder: URL) {
        self.folder = folder
    }

    private var urls: [URL] {
        let files = try? FileManager.default.contentsOfDirectory(at: folder, includingPropertiesForKeys: nil, options: .skipsHiddenFiles)
            .filter { $0.pathComponents.last?.hasMatches(for: "\(filenameWithoutExtension)(.\\d+_[\\d\\w\\-]+)?.log") ?? false }
        return files ?? []
    }

    public func loadContent(callback: @escaping (String) -> Void) {
        DispatchQueue.global(qos: .userInitiated).async {
            let result = self.urls.reduce("", { prev, url in
                guard let contents = try? String(contentsOf: url) else {
                    return prev
                }
                return prev + contents + "\n"
            })
            callback(result)
        }
    }

}

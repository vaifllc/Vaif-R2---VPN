//
//  LogsViewModel.swift
//  VaifR2
//
//  Created by VAIF on 1/5/23.
//

import Foundation


struct LogsViewModel {

    let title: String
    let logContent: LogContent

    func loadLogs(callback: @escaping (String) -> Void) {
        logContent.loadContent(callback: callback)
    }
    
}

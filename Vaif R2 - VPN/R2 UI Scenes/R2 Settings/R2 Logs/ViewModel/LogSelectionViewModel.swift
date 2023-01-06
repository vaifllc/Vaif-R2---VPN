//
//  LogSelectionViewModel.swift
//  VaifR2
//
//  Created by VAIF on 1/5/23.
//

import Foundation

final class LogSelectionViewModel {
    
    var pushHandler: ((LogSource) -> Void)?
    
    init() {
        logCells = LogSource.visibleAppSources.compactMap { source in
            return TableViewCellModel.pushStandard(title: source.title, handler: {
                self.pushApplicationLogsViewController(source: source)
            })
        }
    }
    
    var tableViewData: [TableViewSection] {
        let sections: [TableViewSection] = [
            TableViewSection(title: "", showHeader: false, cells: logCells)
        ]
        return sections
    }
    
    private var logCells = [TableViewCellModel]()
        
    private func pushApplicationLogsViewController(source: LogSource) {
        pushHandler?(source)
    }
        
}


//
//  BlockDayLog.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 9/18/22.
//

import Foundation

final class BlockDayLog {
    
    static let shared = BlockDayLog()
    
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a_"
        return formatter
    }()
    
    private let processingQueue = DispatchQueue(label: "Vaif R2 - VPN: BlockDayLogQueue")
    
    private static let kIsBlockLogDisabled = "Vaif R2 - VPN: IsBlockLogDisabled"
    
    private static let userDefaultsKey = "Vaif R2 - VPN: DayLogs"
    private static let maxSize = 5000
    private static let maxReduction = 4500
    
    private init() { }
    
    var isDisabled: Bool {
        return defaults.bool(forKey: BlockDayLog.kIsBlockLogDisabled)
    }
    
    var isEnabled: Bool {
        return !isDisabled
    }
    
    private var _dayLog: [Any]? {
        #if DEBUG
        dispatchPrecondition(condition: .onQueue(processingQueue))
        #endif
        return defaults.array(forKey: BlockDayLog.userDefaultsKey)
    }
    
    var strings: [String]? {
        return processingQueue.sync {
            self._dayLog as? [String]
        }
    }
    
    func clear() {
        processingQueue.async {
            defaults.set([], forKey: BlockDayLog.userDefaultsKey)
        }
    }
    
    func disable(shouldClear: Bool) {
        defaults.set(true, forKey: BlockDayLog.kIsBlockLogDisabled)
        if shouldClear {
            clear()
        }
    }
    
    func enable() {
        defaults.set(false, forKey: BlockDayLog.kIsBlockLogDisabled)
    }
    
    func append(host: String, date: Date) {
        guard isDisabled == false else {
            // block log is disabled
            return
        }
        
        processingQueue.async {
            let logString = BlockDayLog.dateFormatter.string(from: date) + host
            // reduce log size if it's over the maxSize
            if var dayLog = self._dayLog {
                if dayLog.count > BlockDayLog.maxSize {
                    dayLog = dayLog.suffix(BlockDayLog.maxReduction)
                }
                dayLog.append(logString)
                defaults.set(dayLog, forKey: BlockDayLog.userDefaultsKey)
            } else {
                defaults.set([logString], forKey: BlockDayLog.userDefaultsKey)
            }
        }
    }
}


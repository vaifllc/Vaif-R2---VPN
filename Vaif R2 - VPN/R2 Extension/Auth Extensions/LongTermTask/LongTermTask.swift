//
//  LongTermTask.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 9/26/22.
//

import Foundation
import UIKit


public class LongTermTask {
    
    private let timeout = 20
    private var backgroundTaskID: UIBackgroundTaskIdentifier = .invalid

    public var inProgress = false {
        didSet {
            if oldValue == true, inProgress == false {
                finishLongTermTask()
            }
        }
    }
    
    public init() {
        setupObservers()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
        finishLongTermTask()
    }
    
    private func setupObservers() {
        NotificationCenter.default.removeObserver(self)
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(appMovedToBackground), name: UIApplication.didEnterBackgroundNotification, object: nil)
    }
    
    @objc private func appMovedToBackground() {
        if inProgress {
            scheduleLongTermTask()
        }
    }
    
    private func scheduleLongTermTask() {
        finishLongTermTask()
        backgroundTaskID = UIApplication.shared.beginBackgroundTask { [weak self] in
            self?.finishLongTermTask()
        }
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(timeout)) { [weak self] in
            self?.finishLongTermTask()
        }
        PMLog.debug("Schedule background task: \(self.backgroundTaskID)")
    }
    
    private func finishLongTermTask() {
        if backgroundTaskID == .invalid { return }
        PMLog.debug("End background task: \(backgroundTaskID)")
        UIApplication.shared.endBackgroundTask(backgroundTaskID)
        backgroundTaskID = .invalid
    }
}

//
//  AnnouncementRefresher.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 10/3/22.
//

import Foundation

/// Class that can refresh announcements from API
public protocol AnnouncementRefresher {
    func refresh()
    func clear()
}

public protocol AnnouncementRefresherFactory {
    func makeAnnouncementRefresher() -> AnnouncementRefresher
}

public class AnnouncementRefresherImplementation: AnnouncementRefresher {
    
    public typealias Factory = /*CoreApiServiceFactory &*/ AnnouncementStorageFactory
    private let factory: Factory
    
   // private lazy var coreApiService: CoreApiService = factory.makeCoreApiService()
    private lazy var announcementStorage: AnnouncementStorage = factory.makeAnnouncementStorage()
    
    private var lastRefresh: Date?
    private var minRefreshTime: TimeInterval
    
    public init(factory: Factory, minRefreshTime: TimeInterval = CoreAppConstants.UpdateTime.announcementRefreshTime) {
        self.factory = factory
        self.minRefreshTime = minRefreshTime
        
        NotificationCenter.default.addObserver(self, selector: #selector(featureFlagsChanged), name: PropertiesManager.featureFlagsNotification, object: nil)
    }
    
    public func refresh() {
        if lastRefresh != nil && Date().timeIntervalSince(lastRefresh!) < minRefreshTime {
            return
        }
    
//        coreApiService.getApiNotifications { [weak self] result in
//            switch result {
//            case let .success(announcementsResponse):
//                self?.lastRefresh = Date()
//                self?.announcementStorage.store(announcementsResponse.notifications)
//            case let .failure(error):
//                log.error("Error getting announcements", category: .api, metadata: ["error": "\(error)"])
//            }
//        }
    }
    
    public func clear() {
        lastRefresh = nil
        self.announcementStorage.clear()
    }
    
    @objc func featureFlagsChanged(_ notification: NSNotification) {
//        guard let featureFlags = notification.object as? FeatureFlags else { return }
//        if featureFlags.pollNotificationAPI {
//            refresh()
//        } else { // Hide announcements
//            clear()
//        }
    }
    
}


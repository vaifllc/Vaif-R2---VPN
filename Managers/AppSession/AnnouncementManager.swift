//
//  AnnouncementManager.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 10/4/22.
//

import Foundation

public protocol AnnouncementManager {
    var hasUnreadAnnouncements: Bool { get }
    func fetchCurrentAnnouncements() -> [Announcement]
    func markAsRead(announcement: Announcement)
}

public protocol AnnouncementManagerFactory {
    func makeAnnouncementManager() -> AnnouncementManager
}

public class AnnouncementManagerImplementation: AnnouncementManager {
    
    public typealias Factory = AnnouncementStorageFactory
    private let factory: Factory
    
    private lazy var announcementStorage: AnnouncementStorage = factory.makeAnnouncementStorage()
    
    public init(factory: Factory) {
        self.factory = factory
    }
    
    public func fetchCurrentAnnouncements() -> [Announcement] {
        return announcementStorage.fetch().filter {
            return $0.startTime.isPast && $0.endTime.isFuture && $0.offer != nil
        }
    }
    
    public var hasUnreadAnnouncements: Bool {
        return fetchCurrentAnnouncements().contains(where: { return !$0.wasRead })
    }
    
    public func markAsRead(announcement: Announcement) {
        var announcements = announcementStorage.fetch()
        if let index = announcements.firstIndex(where: { $0.notificationID == announcement.notificationID }) {
            announcements[index].isRead = true
        }
        announcementStorage.store(announcements)
    }
    
}


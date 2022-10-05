//
//  Announcement.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 10/4/22.
//


import Foundation

/// API calls this thing Notification
public struct Announcement: Codable {
    
    public let notificationID: String
    public let startTime: Date
    public let endTime: Date
    public let type: Int
    public let offer: Offer?
    
    // Is set from the app, NOT api
    public var isRead: Bool? = false
    
    // Wrapper param that returns false in case isRead is nil
    public var wasRead: Bool {
        return isRead == true
    }
    
    mutating func setAsRead(_ read: Bool) {
        isRead = read
    }
    
}


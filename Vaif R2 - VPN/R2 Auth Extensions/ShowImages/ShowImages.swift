//
//  ShowImages.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 9/22/22.
//

import Foundation

public struct ShowImages: OptionSet {
    public init(rawValue: Int) {
        self.rawValue = rawValue
    }

    public let rawValue: Int
    // 0 for none, 1 for remote, 2 for embedded, 3 for remote and embedded (

    public static let none     = ShowImages([])
    public static let remote   = ShowImages(rawValue: 1 << 0) // auto load remote images
    public static let embedded = ShowImages(rawValue: 1 << 1) // auto load embedded images
}


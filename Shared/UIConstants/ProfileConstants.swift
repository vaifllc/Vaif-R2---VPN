//
//  ProfileConstants.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 12/28/22.
//

#if canImport(UIKit)
import UIKit
#elseif canImport(Cocoa)
import Cocoa
#endif


public class ProfileConstants {
    // WARNING: consuming client must contain "fastest" and "random" image assets
//    public static func defaultProfiles(connectionProtocol: ConnectionProtocol) -> [Profile] {
//        return
//            [ Profile(id: "st_f", accessTier: 0, profileIcon: .image(IconProvider.bolt), profileType: .system,
//                      serverType: .unspecified, serverOffering: .fastest(nil), name: LocalizedString.fastest, connectionProtocol: connectionProtocol),
//              Profile(id: "st_r", accessTier: 0, profileIcon: .image(IconProvider.arrowsSwapRight), profileType: .system,
//                      serverType: .unspecified, serverOffering: .random(nil), name: LocalizedString.random, connectionProtocol: connectionProtocol) ]
//    }

#if canImport(UIKit)
    public typealias ProfileColors = [UIColor]
#elseif canImport(Cocoa)
    public typealias ProfileColors = [NSColor]
#endif

    public static let profileColors: ProfileColors = [
        ColorProvider.PurpleBase,
        ColorProvider.PinkBase,
        ColorProvider.StrawberryBase,
        ColorProvider.CarrotBase,
        ColorProvider.SaharaBase,
        ColorProvider.SlateblueBase,
        ColorProvider.PacificBase,
        ColorProvider.ReefBase,
        ColorProvider.FernBase,
        ColorProvider.OliveBase
    ]
}


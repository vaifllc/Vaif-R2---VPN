//
//  MapConstants.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 1/3/23.
//

import UIKit

class MapConstants {
    
    class Container {
        static let leftAnchor = 0
        static let topAnchor = 25
        static let bottomAnchorA = 230
        static let bottomAnchorB = 274
        static let bottomAnchorC = 359
        static let iPadLandscapeLeftAnchor = 375
        static let iPadLandscapeTopAnchor = 0
        static let iPadLandscapeBottomAnchor = 0
        
        static func getTopAnchor() -> Int {
            if UIDevice.current.userInterfaceIdiom == .pad && UIApplication.shared.statusBarOrientation.isLandscape && !UIApplication.shared.isSplitOrSlideOver {
                return iPadLandscapeTopAnchor
            }
            
            if UIDevice.current.hasNotch {
                return topAnchor / 2
            }
            
            return topAnchor + 10
        }
        
        static func getLeftAnchor() -> Int {
            if UIDevice.current.userInterfaceIdiom == .pad && UIApplication.shared.statusBarOrientation.isLandscape && !UIApplication.shared.isSplitOrSlideOver {
                return iPadLandscapeLeftAnchor
            }
            
            return leftAnchor
        }
        
        static func getBottomAnchor() -> Int {
            if UIDevice.current.userInterfaceIdiom == .pad && UIApplication.shared.statusBarOrientation.isLandscape && !UIApplication.shared.isSplitOrSlideOver {
                return iPadLandscapeBottomAnchor
            }
            
            if Application.shared.settings.connectionProtocol.tunnelType() != .ipsec && UserDefaults.shared.isMultiHop {
                return bottomAnchorC
            }
            
            if Application.shared.settings.connectionProtocol.tunnelType() != .ipsec {
                return bottomAnchorB
            }
            
            return bottomAnchorA
        }
    }
    
}


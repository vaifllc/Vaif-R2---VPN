//
//  FloatingPanelMainLayout.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 12/31/22.
//

import Foundation
import FloatingPanel

class FloatingPanelMainLayout: FloatingPanelLayout {
    
    // MARK: - Override public properties -
    
    public var initialPosition: FloatingPanelPosition {
        if UIDevice.current.userInterfaceIdiom == .pad && UIApplication.shared.statusBarOrientation.isLandscape && !UIApplication.shared.isSplitOrSlideOver {
            return .full
        }
        
        return .half
    }
    
    public var supportedPositions: Set<FloatingPanelPosition> {
        if UIDevice.current.userInterfaceIdiom == .pad && UIApplication.shared.statusBarOrientation.isLandscape && !UIApplication.shared.isSplitOrSlideOver {
            return [.full]
        }
        
        return [.full, .half]
    }
    
    // MARK: - Private properties -
    
    private let bottomSafeArea = UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0
    
    private var halfHeight: CGFloat {
        if Application.shared.settings.connectionProtocol.tunnelType() != .ipsec && UserDefaults.shared.isMultiHop {
            return 359 - bottomSafeArea
        }
        
        if Application.shared.settings.connectionProtocol.tunnelType() != .ipsec {
            return 274 - bottomSafeArea
        }
        
        return 230 - bottomSafeArea
    }
    
    // MARK: - Override public methods -

    public func insetFor(position: FloatingPanelPosition) -> CGFloat? {
        if UIDevice.current.userInterfaceIdiom == .pad && UIApplication.shared.statusBarOrientation.isLandscape && !UIApplication.shared.isSplitOrSlideOver {
            switch position {
            case .full:
                return -20
            default:
                return nil
            }
        }
        
        switch position {
        case .full:
            return 10
        case .half:
            return halfHeight
        default:
            return nil
        }
    }

    public func prepareLayout(surfaceView: UIView, in view: UIView) -> [NSLayoutConstraint] {
        if let surfaceView = surfaceView as? FloatingPanelSurfaceView {
            if UIDevice.current.userInterfaceIdiom == .pad && UIApplication.shared.statusBarOrientation.isLandscape && !UIApplication.shared.isSplitOrSlideOver {
                surfaceView.grabberHandle.isHidden = true
                surfaceView.cornerRadius = 0
            } else {
                surfaceView.grabberHandle.isHidden = false
                surfaceView.cornerRadius = 15
            }
        }
        
        if UIDevice.current.userInterfaceIdiom == .pad && UIApplication.shared.statusBarOrientation.isLandscape && !UIApplication.shared.isSplitOrSlideOver {
            return [
                surfaceView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 0),
                surfaceView.widthAnchor.constraint(equalToConstant: 375)
            ]
        }
        
        if UIDevice.current.userInterfaceIdiom == .pad && UIApplication.shared.statusBarOrientation.isPortrait && !UIApplication.shared.isSplitOrSlideOver {
            return [
                surfaceView.widthAnchor.constraint(equalToConstant: 520),
                surfaceView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor)
            ]
        }
        
        return [
            surfaceView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 0),
            surfaceView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: 0)
        ]
    }
    
    public func backdropAlphaFor(position: FloatingPanelPosition) -> CGFloat {
        if position == .full && (UIDevice.current.userInterfaceIdiom == .phone || UIApplication.shared.statusBarOrientation.isPortrait) {
            return 0.3
        }
        
        return 0
    }
    
}

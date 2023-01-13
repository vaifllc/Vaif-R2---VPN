//
//  ServerItemViewModelCore.swift
//  VaifR2
//
//  Created by VAIF on 1/9/23.
//

import Foundation

open class ServerItemViewModelCore {
    public let serverModel: ServerModel
    //public var vpnGateway: VpnGatewayProtocol
    public let appStateManager: AppStateManager
    public let propertiesManager: PropertiesManagerProtocol
//    public var isSmartAvailable: Bool { serverModel.isVirtual }
//    public var isTorAvailable: Bool { serverModel.feature.contains(.tor) }
//    public var isP2PAvailable: Bool { serverModel.feature.contains(.p2p) }
//    public var isPartnerServer: Bool { serverModel.feature.contains(.partner) }

    public var isSecureCoreEnabled: Bool {
//        return serverModel.isSecureCore
        return false
    }

    public var load: Int {
        return 55
    }

    public var underMaintenance: Bool {
        //return serverModel.underMaintenance
        return false
    }

    public var isUsersTierTooLow: Bool {
        return userTier < serverModel.tier
    }

    public var isStreamingAvailable: Bool {
//        guard !isSecureCoreEnabled,
//              serverModel.feature.contains(.streaming) else { return false }
//        let tier = String(serverModel.tier)
//        let countryCode = serverModel.countryCode
//        return propertiesManager.streamingServices[countryCode]?[tier] != nil
        return false
    }

    public var alphaOfMainElements: CGFloat {
        if underMaintenance {
            return 0.25
        }

        if isUsersTierTooLow {
            return 0.5
        }

        return 1.0
    }

    public init(serverModel: ServerModel,
                //vpnGateway: VpnGatewayProtocol,
                appStateManager: AppStateManager,
                propertiesManager: PropertiesManagerProtocol) {
        self.serverModel = serverModel
        //self.vpnGateway = vpnGateway
        self.appStateManager = appStateManager
        self.propertiesManager = propertiesManager
    }

//    public var partners: [Partner] {
//        guard isPartnerServer else {
//            return []
//        }
//        return propertiesManager.partnerTypes
//            .flatMap {
//                $0.partners
//            }
//            .filter {
//                $0.logicalIDs.contains(serverModel.id)
//            }
//    }

    var userTier: Int {
        return CoreAppConstants.VpnTiers.plus
//        do {
//            return try vpnGateway.userTier()
//        } catch {
//            return CoreAppConstants.VpnTiers.free
//        }
    }
}


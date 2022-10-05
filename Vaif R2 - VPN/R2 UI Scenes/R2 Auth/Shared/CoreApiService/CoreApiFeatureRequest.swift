//
//  CoreApiFeatureRequest.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 10/4/22.
//

import Foundation
public enum CoreApiFeature: String {
    case onboardingShowFirstConnection = "OnboardingShowFirstConnection"
}

final class CoreApiFeatureRequest: Request {
    let feature: CoreApiFeature

    init(feature: CoreApiFeature) {
        self.feature = feature
    }

    var path: String {
        return "/core/v4/features/\(feature.rawValue)"
    }

    var isAuth: Bool {
        return false
    }
}

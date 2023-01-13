//
//  ServersFeaturesInformationViewModel.swift
//  VaifR2
//
//  Created by VAIF on 1/7/23.
//

import UIKit


protocol ServersFeaturesInformationViewModel {
    func titleFor( _ section: Int ) -> String
    func featuresCount(for section: Int) -> Int
    func getFeatureViewModel( indexPath: IndexPath ) -> FeatureCellViewModel
    var totalFeatures: Int { get }
    var headerHeight: CGFloat { get }
}

class ServersFeaturesInformationViewModelImplementation: ServersFeaturesInformationViewModel {
    
    let features: [[FeatureCellViewModel]] = [
        [
            SmartRoutingFeature(),
            StreamingFeature(),
            P2PFeature(),
            TorFeature()
        ],
        [
            LoadPerformanceFeature()
        ]
    ]
    
    // MARK: - ServersFeaturesInformationViewModel
    
    let headerHeight: CGFloat = 52
    
    var totalFeatures: Int {
        return features.count
    }
    
    func featuresCount(for section: Int) -> Int {
        return features[section].count
    }
    
    func getFeatureViewModel(indexPath: IndexPath) -> FeatureCellViewModel {
        return features[indexPath.section][indexPath.row]
    }
    
    func titleFor(_ section: Int) -> String {
        return section == 0 ? LocalizedString.featuresTitle : LocalizedString.performanceTitle
    }
}


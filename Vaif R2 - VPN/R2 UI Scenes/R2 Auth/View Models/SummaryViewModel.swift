//
//  SummaryViewModel.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 9/26/22.
//

import Foundation
import UIKit

class SummaryViewModel {
    
    private let planName: String?
    private let screenVariant: SummaryScreenVariant
    private let clientApp: ClientApp
    
    // MARK: Public interface
    
    init(planName: String?, screenVariant: SummaryScreenVariant, clientApp: ClientApp) {
        self.planName = planName
        self.screenVariant = screenVariant
        self.clientApp = clientApp
    }
    
    var descriptionText: NSAttributedString {
        let attrFont = UIFont.systemFont(ofSize: 17, weight: .bold)
        if let planName = planName {
            return String(format: CoreString._su_summary_paid_description, planName).getAttributedString(replacement: planName, attrFont: attrFont)
        } else {
            return CoreString._su_summary_free_description.getAttributedString(replacement: CoreString._su_summary_free_description_replacement, attrFont: attrFont)
        }
    }
    
    var summaryImage: UIImage? {
        switch screenVariant {
        case .noSummaryScreen:
            return nil
        case .screenVariant(let screenVariant):
            if case .custom(let data) = screenVariant {
                return data.image
            }
        }
        return nil
    }

    var startButtonText: String? {
        switch screenVariant {
        case .noSummaryScreen:
            return nil
        case .screenVariant(let screenVariant):
            switch screenVariant {
            case .mail(let text), .vpn(let text), .drive(let text), .calendar(let text):
                return text
            case .custom(let data):
                return data.startButtonText
            }
        }
    }
    
    var brandIcon: UIImage? {
        switch clientApp {
        case .mail, .drive, .calendar, .other:
            return LoginUIImages.brandIconForProton
        case .vpn:
            return LoginUIImages.brandIconForVPN
        }
    }
}

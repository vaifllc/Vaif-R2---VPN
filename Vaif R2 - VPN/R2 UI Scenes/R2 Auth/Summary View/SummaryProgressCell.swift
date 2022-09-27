//
//  SummaryProgressCell.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 9/26/22.
//

import Foundation
import UIKit


final class SummaryProgressCell: UITableViewCell {

    static let reuseIdentifier = "SummaryProgressCell"

    // MARK: - Outlets

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView! {
        didSet {
            activityIndicator.transform = CGAffineTransform(scaleX: 0.65, y: 0.65)
        }
    }
    @IBOutlet private weak var stepImageView: UIImageView!
    @IBOutlet private weak var stepLabel: UILabel!
    @IBOutlet weak var labelLeadingConstraint: NSLayoutConstraint!
    
    // MARK: - Properties

    func configureCell(displayProgress: DisplayProgress) {
        backgroundColor = ColorProvider.BackgroundNorm
        if displayProgress.state == .waiting {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
        stepImageView?.image = displayProgress.state.image
        stepImageView?.tintColor = ColorProvider.InteractionNorm
        stepLabel.text = displayProgress.step.localizedString
        stepLabel.textColor = displayProgress.state == .initial ? ColorProvider.TextDisabled : ColorProvider.TextNorm
        activityIndicator.color = ColorProvider.BrandNorm
    }
    
    var getWidth: CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: stepLabel.font]
        let size = stepLabel.text?.size(withAttributes: fontAttributes as [NSAttributedString.Key: Any])
        return (size?.width ?? 0) + labelLeadingConstraint.constant + 1
    }
}


//
//  FeatureTableViewCell.swift
//  VaifR2
//
//  Created by VAIF on 1/7/23.
//

import UIKit


class FeatureTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var iconIV: UIImageView!
    @IBOutlet private weak var titleLbl: UILabel!
    @IBOutlet private weak var descriptionLbl: UILabel!
    @IBOutlet private weak var learnMoreBtn: UIButton!
    
    @IBOutlet weak var loadViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet private weak var loadView: UIView!
    @IBOutlet private weak var loadLowView: UIView!
    @IBOutlet private weak var loadLowLbl: UILabel!
    @IBOutlet private weak var loadMediumView: UIView!
    @IBOutlet private weak var loadMediumLbl: UILabel!
    @IBOutlet private weak var loadHighView: UIView!
    @IBOutlet private weak var loadHighLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        backgroundColor = .secondaryBackgroundColor()
        learnMoreBtn.setTitleColor(UIColor.textAccent(), for: .normal)
        learnMoreBtn.tintColor = UIColor.textAccent()
        learnMoreBtn.setImage(IconProvider.arrowOutSquare, for: .normal)
    }
    
    var viewModel: FeatureCellViewModel! {
        didSet {
            titleLbl.text = viewModel.title
            iconIV.image = viewModel.icon

            descriptionLbl.text = viewModel.description
            learnMoreBtn.setTitle(LocalizedString.learnMore, for: .normal)
            
            if viewModel.displayLoads {
                loadView.isHidden = false
                loadViewHeightConstraint.constant = 32
                loadLowLbl.text = LocalizedString.performanceLoadLow
                loadLowView.backgroundColor = .notificationOKColor()
                loadMediumLbl.text = LocalizedString.performanceLoadMedium
                loadMediumView.backgroundColor = .notificationWarningColor()
                loadHighLbl.text = LocalizedString.performanceLoadHigh
                loadHighView.backgroundColor = .notificationErrorColor()
            } else {
                loadView.isHidden = true
                loadViewHeightConstraint.constant = 0
            }
        }
    }
    
    // MARK: - Actions
    
    @IBAction private func didTapLearnMore(_ sender: Any) {
        SafariService.openLink(url: viewModel.urlContact)
    }
}


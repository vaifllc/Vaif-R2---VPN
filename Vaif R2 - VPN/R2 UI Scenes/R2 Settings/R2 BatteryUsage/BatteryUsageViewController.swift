//
//  BatteryUsageViewController.swift
//  VaifR2
//
//  Created by VAIF on 1/5/23.
//

import UIKit


class BatteryUsageViewController: UIViewController {
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var moreButton: UIButton!
    private let textFontSize: CGFloat = 14
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupTranslations()
    }

    private func setupTranslations() {
        self.title = LocalizedString.batteryTitle
        descriptionLabel.text = LocalizedString.batteryDescription
        moreButton.setTitle(LocalizedString.batteryMore, for: .normal)
    }

    private func setupViews() {
        view.backgroundColor = .backgroundColor()
        
        descriptionLabel.font = UIFont.systemFont(ofSize: textFontSize)
        descriptionLabel.textColor = .normalTextColor()
        
        moreButton.tintColor = .brandColor()
        moreButton.titleLabel?.font = UIFont.systemFont(ofSize: textFontSize)
    }
    
    @IBAction func learMore() {
        SafariService.openLink(url: CoreAppConstants.ProtonVpnLinks.batteryOpenVpn)
    }

}


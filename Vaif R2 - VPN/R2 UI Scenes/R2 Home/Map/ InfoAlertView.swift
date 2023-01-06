//
//   InfoAlertView.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 1/3/23.
//

import UIKit

enum InfoAlertViewType {
    case alert
    case info
}

protocol InfoAlertViewDelegate: AnyObject {
    func action()
}

class InfoAlertView: UIView {
    
    // MARK: - @IBOutlets -
    
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var actionButton: UIButton!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var centerXConstraint: NSLayoutConstraint!
    
    // MARK: - @IBActions -
    
    @IBAction func action(_ sender: UIButton) {
        delegate?.action()
    }
    
    // MARK: - Properties -
    
    weak var delegate: InfoAlertViewDelegate?
    
    private var bottomSafeArea: CGFloat {
        if UIDevice.current.hasNotch {
            return 35
        }
        
        return 0
    }
    
    // MARK: - View lifecycle -
    
    override func awakeFromNib() {
        isHidden = true
    }
    
    // MARK: - Methods -
    
    func show(viewModel: InfoAlertViewModel) {
        updateAutoLayout()
        setupAppearance(type: viewModel.type)
        setupText(text: viewModel.text)
        setupAction(actionText: viewModel.actionText)
        isHidden = false
    }
    
    func hide() {
        isHidden = true
    }
    
    // MARK: - Private methods -
    
    private func setupAppearance(type: InfoAlertViewType) {
        switch type {
        case .alert:
            backgroundColor = UIColor.init(named: Theme.ivpnLightYellow)
            textLabel.textColor = UIColor.init(named: Theme.ivpnDarkYellow)
            actionButton.setTitleColor(UIColor.init(named: Theme.ivpnDarkYellow), for: .normal)
            iconImage.image = UIImage(named: "icon-alert-dark-yellow")
        case .info:
            backgroundColor = UIColor.init(named: Theme.ivpnLightNavy)
            textLabel.textColor = UIColor.init(named: Theme.ivpnDarkNavy)
            actionButton.setTitleColor(UIColor.init(named: Theme.ivpnDarkNavy), for: .normal)
            iconImage.image = UIImage(named: "alert-info-dark-navy")
        }
    }
    
    private func setupText(text: String) {
        textLabel.text = text
    }
    
    private func setupAction(actionText: String) {
        if actionText.isEmpty {
            actionButton.isHidden = true
        } else {
            actionButton.setTitle(actionText, for: .normal)
        }
    }
    
    private func updateAutoLayout() {
        if UIDevice.current.userInterfaceIdiom == .pad && UIApplication.shared.statusBarOrientation.isLandscape && !UIApplication.shared.isSplitOrSlideOver {
            centerXConstraint.constant = CGFloat(MapConstants.Container.iPadLandscapeLeftAnchor / 2)
            bottomConstraint.constant = 20
            return
        }
        
        centerXConstraint.constant = 0
        
        if Application.shared.settings.connectionProtocol.tunnelType() != .ipsec && UserDefaults.shared.isMultiHop {
            bottomConstraint.constant = CGFloat(MapConstants.Container.bottomAnchorC + 22) - bottomSafeArea
            return
        }

        if Application.shared.settings.connectionProtocol.tunnelType() != .ipsec {
            bottomConstraint.constant = CGFloat(MapConstants.Container.bottomAnchorB + 22) - bottomSafeArea
            return
        }
        
        bottomConstraint.constant = CGFloat(MapConstants.Container.bottomAnchorA + 22) - bottomSafeArea
    }
    
}

//
//  ButtonWithLoadingTableViewCell.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 12/28/22.
//

import UIKit

final class ButtonWithLoadingTableViewCell: UITableViewCell {
    
    @IBOutlet private var button: UIButton!
    @IBOutlet private var loading: UIActivityIndicatorView!
    
    var controller: ButtonWithLoadingIndicatorController? {
        didSet {
            controller?.startLoading = { [weak self] in
                self?.loading.isHidden = false
                self?.loading.startAnimating()
            }
            controller?.stopLoading = { [weak self] in
                self?.loading.isHidden = true
                self?.loading.stopAnimating()
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundColor = .secondaryBackgroundColor()
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17)
    }
    
    func setup(title: String,
               accessibilityIdentifier: String?,
               color: UIColor,
               controller: ButtonWithLoadingIndicatorController) {
        self.button.setTitle(title, for: .normal)
        self.button.setTitleColor(color, for: .normal)
        self.button.accessibilityIdentifier = accessibilityIdentifier
        self.controller = controller
    }
    
    @IBAction private func onPressed(_ sender: Any) {
        assert(controller != nil, "It's required for the cell to have a controller associated")
        controller?.onPressed()
    }
}


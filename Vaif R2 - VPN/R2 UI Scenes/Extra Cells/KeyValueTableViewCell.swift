//
//  KeyValueTableViewCell.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 12/28/22.
//

import UIKit

class KeyValueTableViewCell: UITableViewCell {
    @IBOutlet weak var keyLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var stackView: UIStackView!
    
    var completionHandler: (() -> Void)?
    
    var viewModel: [String: String]? {
        didSet {
            if let viewModel = viewModel {
                keyLabel.text = viewModel.first?.key
                valueLabel.text = viewModel.first?.value
            }
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundColor = .secondaryBackgroundColor()
        keyLabel.textColor = .weakTextColor()
        valueLabel.textColor = .normalTextColor()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        selectionStyle = .none
    }
    
    func select() {
        completionHandler?()
    }
    
    public func showDisclosure(_ show: Bool) {
        if show {
            accessoryType = .disclosureIndicator
            stackView.spacing = 30 // Makes right label start at the middle of the view
        } else {
            accessoryType = .none
            stackView.spacing = 0
        }
    }
    
}


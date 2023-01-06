//
//  StandardTableViewCell.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 12/28/22.
//

import UIKit

class StandardTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    var completionHandler: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupViews()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        selectionStyle = .none
    }
    
    func select() {
        completionHandler?()
    }
    
    func invert() {
        setupViews(inverted: true)
    }
    
    private func setupViews(inverted: Bool = false) {
        backgroundColor = .secondaryBackgroundColor()
        titleLabel.font = UIFont.systemFont(ofSize: 17)
        subtitleLabel.font = UIFont.systemFont(ofSize: 17)
        
        if !inverted {
            titleLabel.textColor = .normalTextColor()
            subtitleLabel.textColor = .weakTextColor()
        } else {
            titleLabel.textColor = .weakTextColor()
            subtitleLabel.textColor = .normalTextColor()
        }
        
    }
}


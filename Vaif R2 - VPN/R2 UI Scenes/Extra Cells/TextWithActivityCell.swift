//
//  TextWithActivityCell.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 12/28/22.
//

import UIKit

class TextWithActivityCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupViews()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        selectionStyle = .none
    }
    
    private func setupViews(inverted: Bool = false) {
        backgroundColor = .secondaryBackgroundColor()
        titleLabel.font = UIFont.systemFont(ofSize: 17)
    }
    
}


//
//  AccountDetailsTableViewCell.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 12/28/22.
//

import UIKit


final class AccountDetailsTableViewCell: UITableViewCell {
    
    @IBOutlet private var initialsRect: UIView!
    @IBOutlet private var initialsText: UILabel!
    @IBOutlet private var username: UILabel!
    @IBOutlet private var plan: UILabel!
    
    var completionHandler: (() -> Void)?
    
    func select() {
        completionHandler?()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupViews()
    }
    
    func setupViews() {
        backgroundColor = .secondaryBackgroundColor()
        initialsRect.layer.cornerRadius = 8
        initialsRect.backgroundColor = .brandColor()
        initialsText.textColor = ColorProvider.White
        username.textColor = ColorProvider.TextNorm
        plan.textColor = ColorProvider.TextWeak
    }
    
    func setup(initials: NSAttributedString,
               username: NSAttributedString,
               plan: NSAttributedString,
               handler: @escaping () -> Void) {
        self.initialsText.attributedText = initials
        self.username.attributedText = username
        self.plan.attributedText = plan
        self.completionHandler = handler
    }
}


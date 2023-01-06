//
//  InstructionStepView.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 12/28/22.
//

import UIKit

class InstructionStepView: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var label: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadNib()
    }
    
    func loadNib() {
        Bundle.main.loadNibNamed("InstructionStepView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = bounds
        contentView.backgroundColor = .clear
        
        layer.cornerRadius = bounds.width * 0.5
        backgroundColor = .backgroundColor()
        
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .normalTextColor()
    }
}


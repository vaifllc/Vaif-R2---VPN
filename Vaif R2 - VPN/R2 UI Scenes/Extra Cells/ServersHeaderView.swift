//
//  ServersHeaderView.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 12/28/22.
//

import UIKit


class ServersHeaderView: UITableViewHeaderFooterView {

    @IBOutlet private weak var colorView: UIView!
    @IBOutlet private weak var serversName: UILabel!
    @IBOutlet private weak var infoBtn: UIButton!
        
    var callback: ( () -> Void )? {
        didSet {
            infoBtn.isHidden = callback == nil
        }
    }
    
    func setName(name: String) {
        serversName.text = name
    }
    
    func setColor(color: UIColor) {
        colorView.backgroundColor = color
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        colorView.backgroundColor = ColorProvider.FloatyBackground
        serversName.textColor = .weakTextColor()
        infoBtn.setImage(IconProvider.infoCircle, for: .normal)
        infoBtn.tintColor = .iconNorm()
    }

    @IBAction private func didTapInfoBtn(_ sender: Any) {
        callback?()
    }
}


//
//  ColorPickerTableViewCell.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 12/28/22.
//

import UIKit

class ColorPickerTableViewCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundColor = .backgroundColor()
        collectionView.backgroundColor = .backgroundColor()
        
        collectionView.register(ColorPickerItem.nib,
                                forCellWithReuseIdentifier: ColorPickerItem.identifier)
    }
    
}


//
//  UISearchBar+helper.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 9/26/22.
//

import Foundation
import UIKit

public extension UISearchBar {
    var searchBarTextField: UITextField? {
        if #available(iOS 13.0, *) {
            return searchTextField
        } else {
            return subviews.first?.subviews.first(where: { $0 as? UITextField != nil }) as? UITextField
        }
    }
}

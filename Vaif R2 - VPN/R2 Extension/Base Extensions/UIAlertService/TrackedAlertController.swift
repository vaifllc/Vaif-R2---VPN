//
//  TrackedAlertController.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 9/27/22.
//

import Foundation
import UIKit

/// Used to more reliably track alert controllers being dismissed
class TrackedAlertController: UIAlertController {
    
    var dismissCompletion: (() -> Void)?
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        dismissCompletion?()
    }
    
}

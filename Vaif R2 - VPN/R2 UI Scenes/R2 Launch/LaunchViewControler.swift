//
//  LaunchViewControler.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 10/3/22.
//

import Foundation
import UIKit


final class LaunchViewController: UIViewController {
    enum AnimationMode {
        case delayed
        case immediate
    }

    @IBOutlet private weak var loadingIndicator: UIActivityIndicatorView!

    var mode: AnimationMode = .delayed
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        loadingIndicator.isHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        switch mode {
        case .delayed:
            Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { [weak self] _ in
                self?.loadingIndicator.isHidden = false
            }
        case .immediate:
            loadingIndicator.isHidden = false
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        loadingIndicator.isHidden = true
    }
}

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
    var splashPresenter: SplashPresenterDescription? = SplashPresenter()
    private let container = DependencyContainer()
    private lazy var navigationService: NavigationService = container.makeNavigationService()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        loadingIndicator.isHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        switch mode {
        case .delayed:
//            Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { [weak self] _ in
//                self?.loadingIndicator.isHidden = false
//            }
            self.loadingIndicator.isHidden = false
            Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { _ in
                self.loadingIndicator.isHidden = true
                self.navigationService.launched()
                print("Done!") }
            
        case .immediate:
            loadingIndicator.isHidden = false
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        loadingIndicator.isHidden = true
    }
}

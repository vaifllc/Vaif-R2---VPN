//
//  LaunchViewControler.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 10/3/22.
//

import Foundation
import UIKit
import SecurityKit


final class LaunchViewController: UIViewController {
    enum AnimationMode {
        case delayed
        case immediate
    }

    @IBOutlet private weak var loadingIndicator: UIActivityIndicatorView!

    @IBOutlet var loadingLbl: UILabel!
    var mode: AnimationMode = .delayed
    var splashPresenter: SplashPresenterDescription? = SplashPresenter()
    private let container = DependencyContainer()
    private lazy var navigationService: NavigationService = container.makeNavigationService()
    public var readyGroup: DispatchGroup? = DispatchGroup()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        loadingIndicator.isHidden = true
        loadingLbl.isHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        switch mode {
        case .delayed:
            self.loadingIndicator.isHidden = false
            self.loadingLbl.isHidden = false
            Timer.scheduledTimer(withTimeInterval: 1.5, repeats: true) { _ in
                self.loadingLbl.text = "Configuring..."
                DispatchQueue.main.async { [weak self] in
                    self?.jailbreakCheck()
                }
            }
            
        case .immediate:
            loadingIndicator.isHidden = false
        }
    }
    
    func launchWelcome(){
        self.whenReady(queue: DispatchQueue.main) {
            self.navigationService.launched()
        }
    }
    
    func jailbreakCheck(){
        self.loadingLbl.text = "Running Jailbreak Check..."
        if SecurityKit.isDeviceJailBroken() {
            print(" jailbroken")
        }else{
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self.simulatorkCheck()
                print("not jailbroken")
            }
        }
    }
    
    func simulatorkCheck(){
        self.loadingLbl.text = "Running Device Check..."
        if SecurityKit.isDeviceSimulator() {
            print("Is Simulator")
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                print ("Is Not Simulator")
                self.reverseEGCheck()
            }
        }
    }
    
    func reverseEGCheck(){
        self.loadingLbl.text = "Configuring..."
        if SecurityKit.isRevereseEngineeringToolsExecuted() {
            print("RevereseEngineeringToolsExecuted Is True")
        }else{
            DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
                print("isRevereseEngineeringToolsExecuted Is False")
                self.launchWelcome()
                self.loadingIndicator.isHidden = true
            }
        }
    }
    
    func jailbreakCheck1(){
        self.loadingLbl.text = "Configuring..."
        if SecurityKit.isDeviceJailBroken() {
            print(" jailbroken")
        }else{
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.simulatorkCheck1()
                print("not jailbroken")
            }
        }
    }
    
    func simulatorkCheck1(){
        self.loadingLbl.text = "Configuring..."
        if SecurityKit.isDeviceSimulator() {
            print("Is Simulator")
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                print ("Is Not Simulator")
                self.reverseEGCheck1()
            }
        }
    }
    
    func reverseEGCheck1(){
        self.loadingLbl.text = "Configuring..."
        if SecurityKit.isRevereseEngineeringToolsExecuted() {
            print("RevereseEngineeringToolsExecuted Is True")
        }else{
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                print("isRevereseEngineeringToolsExecuted Is False")
                self.launchWelcome()
                self.loadingIndicator.isHidden = true
            }
        }
    }
    
    public func whenReady(queue: DispatchQueue, completion: @escaping () -> Void) {
        self.readyGroup?.notify(queue: queue) {
            completion()
            self.readyGroup = nil
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        loadingIndicator.isHidden = true
    }
}

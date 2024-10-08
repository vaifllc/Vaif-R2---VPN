//
//  LaunchViewControler.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 10/3/22.
//

import Foundation
import UIKit
import SecurityKit
import DeviceKit


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
    let device = Device.current
    
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
            Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
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
            if let _ = WitWork.shared.user {
                self.navigationService.presentHomeViewController()
            } else {
                self.navigationService.launched()
            }
        }
    }
    
    func jailbreakCheck(){
        if SecurityKit.isDeviceJailBroken() {
            print(" jailbroken")
        }else{
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.simulatorkCheck()
                print("not jailbroken")
            }
        }
    }
    
    func simulatorkCheck(){
        if SecurityKit.isDeviceSimulator() {
            print("Is Simulator")
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                print ("Is Not Simulator")
                self.reverseEGCheck()
            }
        }
    }
    
    func reverseEGCheck(){
        if SecurityKit.isRevereseEngineeringToolsExecuted() {
            print("RevereseEngineeringToolsExecuted Is True")
        }else{
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                print("isRevereseEngineeringToolsExecuted Is False")
                self.launchWelcome()
                self.loadingIndicator.isHidden = true
            }
        }
    }
    
    func jailbreakCheck1(){
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

//
//  ConnectionOfflineViewController.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 10/10/22.
//

import Foundation
import UIKit
import Reachability

final class ConnectionOfflineViewController: UIViewController, AccessibleView, Focusable {
    @IBOutlet var retryBtn: ProtonButton!
    @IBOutlet var oopsLbl: UILabel!
    @IBOutlet var errorMsg: UILabel!
    @IBOutlet var loadingIndicator: UIActivityIndicatorView!
    var focusNoMore: Bool = false
    private let container = DependencyContainer()
    private lazy var navigationService: NavigationService = container.makeNavigationService()
    public var readyGroup: DispatchGroup? = DispatchGroup()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    private func setupUI() {
        view.backgroundColor = ColorProvider.BackgroundNorm
        retryBtn.setTitle(CoreString._retry_button, for: .normal)
        retryBtn.setMode(mode: .solid)
    }
    
    private func whenReady(queue: DispatchQueue, completion: @escaping () -> Void) {
        self.readyGroup?.notify(queue: queue) {
            completion()
            self.readyGroup = nil
        }
    }
    
    @IBAction func retryConnection(_ sender: Any) {
        self.oopsLbl.text = ""
        self.errorMsg.text = ""
        self.retryBtn.isEnabled = false
        let reachability = try! Reachability()

        reachability.whenReachable = { reachability in
            if reachability.connection == .cellular {
                self.whenReady(queue: DispatchQueue.main) {
                    self.navigationService.launched()
                }
                
            } else if reachability.connection == .wifi {
                self.whenReady(queue: DispatchQueue.main) {
                    self.navigationService.launched()
                }
            } else if reachability.connection == .unavailable {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                    self.retryBtn.isEnabled = true
                    self.oopsLbl.text = "Still No Connection"
                    self.errorMsg.text = "Please try again. If this error persist please close out the app and try again later"
                }
            }
        }
        
        
        reachability.whenUnreachable = { _ in
            print("Not reachable")
        }

        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }

        
    }
    
    
}

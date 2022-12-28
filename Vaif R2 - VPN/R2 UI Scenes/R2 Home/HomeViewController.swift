//
//  HomeViewController.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 12/23/22.
//

import UIKit
import Foundation
import Lottie
import NetworkExtension
import SideMenu
import Macaw
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth
import FloatingPanel
import NetworkExtension

class HomeViewController : UIViewController, FloatingPanelControllerDelegate {
    
    lazy var db = Firestore.firestore()
    fileprivate var timer: Timer?
    var fpc: FloatingPanelController!
    var floatingPanel: FloatingPanelController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.accessibilityIdentifier = "mainScreen"
//        evaluateFirstRun()
//        initErrorObservers()
        initFloatingPanel()
        //addObservers()
//        startServersUpdate()
//        startVPNStatusObserver()
        setupUI()
        tabBarItem = UITabBarItem(title: "Home", image: IconProvider.house, tag: 2)
        tabBarItem.accessibilityIdentifier = "Home"
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        refreshUI()
        //initConnectionInfo()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        floatingPanel.updateLayout()
       // mainView.updateLayout()
    }
    
    // MARK: - Methods -
    
    func refreshUI() {
        updateFloatingPanelLayout()
    }
    
    func setupUI() {
        view.backgroundColor = ColorProvider.BackgroundNorm
        
    }
    
    func expandFloatingPanel() {
        floatingPanel.move(to: .full, animated: true)
    }
    
    @objc private func updateFloatingPanelLayout() {
        floatingPanel.updateLayout()
        //mainView.setupView(animated: false)
    }
    
    
    
    private func initFloatingPanel() {
        floatingPanel = FloatingPanelController()
        floatingPanel.setup()
        floatingPanel.delegate = self
        floatingPanel.addPanel(toParent: self)
        floatingPanel.show(animated: true)
    }
    
}

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



class HomeViewController: UIViewController {
    
    // MARK: - @IBOutlets -
    
    @IBOutlet weak var mainView: MainView!
    
    // MARK: - Properties -
    
    var floatingPanel: FloatingPanelController!
    private var updateServerListDidComplete = false
    //private var vpnErrorObserver = VPNErrorObserver()
    
    // MARK: - @IBActions -
    
    
    
    // MARK: - View lifecycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.accessibilityIdentifier = "mainScreen"
        evaluateFirstRun()
        initErrorObservers()
        initFloatingPanel()
        addObservers()
        startAPIUpdate()
        startVPNStatusObserver()
        tabBarItem = UITabBarItem(title: "Home", image: IconProvider.house, tag: 2)
        tabBarItem.accessibilityIdentifier = "Home"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        startPingService(updateServerListDidComplete: updateServerListDidComplete)
        refreshUI()
        initConnectionInfo()
    }
    
    deinit {
        Application.shared.connectionManager.removeStatusChangeUpdates()
    }
    
    // MARK: - Segues -
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "ControlPanelSelectServer" {
//            if let navController = segue.destination as? UINavigationController {
//                if let viewController = navController.topViewController as? ServerViewController {
//                    viewController.serverDelegate = floatingPanel.contentViewController as! ControlPanelViewController
//                }
//            }
//        }
//
//        if segue.identifier == "ControlPanelSelectExitServer" {
//            if let navController = segue.destination as? UINavigationController {
//                if let viewController = navController.topViewController as? ServerViewController {
//                    viewController.isExitServer = true
//                }
//            }
//        }
//    }
    
    // MARK: - Interface Orientations -
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        refreshUI()
    }
    
    override func viewLayoutMarginsDidChange() {
        DispatchQueue.async { [self] in
            refreshUI()
        }
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        DispatchQueue.async { [self] in
            refreshUI()
        }
    }
    
    // MARK: - Methods -
    
    func refreshUI() {
        updateFloatingPanelLayout()
        mainView.updateLayout()
    }
    
    func updateStatus(vpnStatus: NEVPNStatus, animated: Bool = true) {
        mainView.updateStatus(vpnStatus: vpnStatus)
        
        if let controlPanelViewController = self.floatingPanel.contentViewController as? ControlPanelViewController {
            controlPanelViewController.updateStatus(vpnStatus: vpnStatus, animated: animated)
        }
        
        Application.shared.connectionManager.statusModificationDate = Date()
    }
    
    @objc func updateGeoLocation() {
        guard let controlPanel = floatingPanel.contentViewController as? ControlPanelViewController else {
            return
        }
        
        controlPanel.controlPanelView.ipv4ViewModel = ProofsViewModel(displayMode: .loading)
        controlPanel.controlPanelView.ipv6ViewModel = ProofsViewModel(displayMode: .loading)
        
        let requestIPv4 = ApiRequestDI(method: .get, endpoint: R2Config.apiGeoLookup, addressType: .IPv4)
        ApiService.shared.request(requestIPv4) { [self] (result: R1Result<GeoLookup>) in
            switch result {
            case .success(let model):
                controlPanel.controlPanelView.ipv4ViewModel = ProofsViewModel(model: model, displayMode: .content)
                mainView.ipv4ViewModel = ProofsViewModel(model: model)
                mainView.infoAlertViewModel.infoAlert = .subscriptionExpiration
                //mainView.updateInfoAlert()

                if !model.isIvpnServer {
                    Application.shared.geoLookup = model
                }
            case .failure:
                controlPanel.controlPanelView.ipv4ViewModel = ProofsViewModel(displayMode: .error)
                mainView.infoAlertViewModel.infoAlert = .connectionInfoFailure
                //mainView.updateInfoAlert()
            }
        }

        let requestIPv6 = ApiRequestDI(method: .get, endpoint: R2Config.apiGeoLookup, addressType: .IPv6)
        ApiService.shared.request(requestIPv6) { [self] (result: R1Result<GeoLookup>) in
            switch result {
            case .success(let model):
                controlPanel.controlPanelView.ipv6ViewModel = ProofsViewModel(model: model, displayMode: .content)
               // mainView.ipv6ViewModel = ProofsViewModel(model: model)
            case .failure:
                controlPanel.controlPanelView.ipv6ViewModel = ProofsViewModel(displayMode: .error)
                //mainView.ipv6ViewModel = ProofsViewModel(displayMode: .error)
            }
        }
    }
    
    func expandFloatingPanel() {
        floatingPanel.move(to: .full, animated: true)
    }
    
    // MARK: - Observers -
    
    private func addObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(updateFloatingPanelLayout), name: Notification.Name.UpdateFloatingPanelLayout, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(vpnConfigurationDisabled), name: Notification.Name.VPNConfigurationDisabled, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(subscriptionActivated), name: Notification.Name.SubscriptionActivated, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateGeoLocation), name: Notification.Name.UpdateGeoLocation, object: nil)
    }
    
    // MARK: - Private methods -
    
    @objc private func updateFloatingPanelLayout() {
        floatingPanel.updateLayout()
        mainView.setupView(animated: false)
    }
    
    @objc private func updateServersList() {
//        ApiService.shared.getServersList(storeInCache: true) { result in
//            self.updateServerListDidComplete = true
//            switch result {
//            case .success(let serverList):
//                Application.shared.serverList = serverList
//                Pinger.shared.serverList = Application.shared.serverList
//                DispatchQueue.async {
//                    Pinger.shared.ping()
//                }
//            default:
//                break
//            }
//        }
    }
    
    @objc private func vpnConfigurationDisabled() {
        updateStatus(vpnStatus: Application.shared.connectionManager.status)
    }
    
    @objc private func subscriptionActivated() {
        mainView.infoAlertViewModel.infoAlert = .subscriptionExpiration
        //mainView.updateInfoAlert()
    }
    
    private func initFloatingPanel() {
        floatingPanel = FloatingPanelController()
        floatingPanel.setup()
        floatingPanel.delegate = self
        floatingPanel.addPanel(toParent: self)
        floatingPanel.show(animated: true)
    }
    
    private func startAPIUpdate() {
        updateServersList()
        Timer.scheduledTimer(timeInterval: 60 * 15, target: self, selector: #selector(updateServersList), userInfo: nil, repeats: true)
    }
    
    private func startPingService(updateServerListDidComplete: Bool) {
        if updateServerListDidComplete {
            DispatchQueue.delay(0.5) {
                Pinger.shared.ping()
            }
        }
    }
    
    private func startVPNStatusObserver() {
        Application.shared.connectionManager.getStatus { [self] _, status2 in
            if status2 == .invalid {
                updateGeoLocation()
            }

            updateStatus(vpnStatus: status2, animated: false)

            Application.shared.connectionManager.onStatusChanged { [self] status2 in
                updateStatus(vpnStatus: status2)
            }
        }
    }
    
    private func initErrorObservers() {
        //vpnErrorObserver.delegate = self
    }
    
    private func initConnectionInfo() {
//        if !NetworkManager.shared.isNetworkReachable {
//            mainView.infoAlertViewModel.infoAlert = .connectionInfoFailure
//            mainView.updateInfoAlert()
//        }
        
        //#if targetEnvironment(simulator)
        updateGeoLocation()
        //#endif
    }
    
    private func evaluateFirstRun() {
        guard UIApplication.shared.isProtectedDataAvailable else {
            return
        }
        
        if UserDefaults.standard.object(forKey: UserDefaults.Key.firstInstall) == nil && UserDefaults.standard.object(forKey: UserDefaults.Key.selectedServerGateway) == nil {
            KeyChain.clearAll()
            UserDefaults.clearSession()
            Application.shared.settings.connectionProtocol = R2Config.defaultProtocol
            Application.shared.settings.saveConnectionProtocol()
            UserDefaults.standard.set(false, forKey: UserDefaults.Key.firstInstall)
            UserDefaults.standard.synchronize()
        }
    }
    
}

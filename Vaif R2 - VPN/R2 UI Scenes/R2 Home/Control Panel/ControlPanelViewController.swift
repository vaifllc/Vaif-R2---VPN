//
//  ControlPanelViewController.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 12/25/22.
//

import UIKit
import NetworkExtension
import Foundation
import Lottie
import NetworkExtension
import SideMenu
import Macaw
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

class ControlPanelViewController: UITableViewController {
    
    // MARK: - @IBOutlets -
    
    @IBOutlet weak var controlPanelView: ControlPanelView!
    
    // MARK: - Properties -
    //    let hud = JGProgressHUD(style: .dark)
    lazy var db = Firestore.firestore()
    fileprivate var timer: Timer?
    var currentServer: ServerModel?
    private var vpnStatusViewModel = VPNStatusViewModel(status: .invalid)
    
    
    // MARK: - @IBActions -
    
    @IBAction func toggleConnect(_ sender: UISwitch) {
        connectionExecute()
        
        // Disable multiple tap gestures on VPN connect button
        sender.isUserInteractionEnabled = false
        DispatchQueue.delay(1) {
            sender.isUserInteractionEnabled = true
        }
    }
    
    
    
    
    // MARK: - View lifecycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        addObservers()
        setupGestureRecognizers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //refreshServiceStatus()

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    // MARK: - Gestures -
    
    private func setupGestureRecognizers() {
//        let entryServerGesture = UILongPressGestureRecognizer(target: self, action: #selector(selectServerlongPress(_:)))
//        entryServerGesture.numberOfTouchesRequired = 3
//        entryServerGesture.minimumPressDuration = 3
//
//        let exitServerGesture = UILongPressGestureRecognizer(target: self, action: #selector(selectExitServerlongPress(_:)))
//        exitServerGesture.numberOfTouchesRequired = 3
//        exitServerGesture.minimumPressDuration = 3
        
        //controlPanelView.entryServerTableCell.addGestureRecognizer(entryServerGesture)

    }
    
//    @objc func selectServerlongPress(_ guesture: UILongPressGestureRecognizer) {
//        guard guesture.state == .recognized else { return }
//        askForCustomServer(isExitServer: false)
//    }
//
//    @objc func selectExitServerlongPress(_ guesture: UILongPressGestureRecognizer) {
//        guard guesture.state == .recognized else { return }
//        askForCustomServer(isExitServer: true)
//    }
    
    // MARK: - Methods -
    
    @objc func connectionExecute() {
        if vpnStatusViewModel.connectToggleIsOn {
            disconnect()
        } else {
            connect()
        }
    }
    
    func connect() {
        
        guard evaluateIsNetworkReachable() else {
            controlPanelView.connectSwitch.setOn(vpnStatusViewModel.connectToggleIsOn, animated: true)
            return
        }
        

        NotificationCenter.default.removeObserver(self, name: Notification.Name.ServiceAuthorized, object: nil)
        NotificationCenter.default.removeObserver(self, name: Notification.Name.SubscriptionActivated, object: nil)
    }
    
    @objc func disconnect() {
        log.info("Disconnect VPN")
        
        
        
        registerUserActivity(type: UserActivityType.Disconnect, title: UserActivityTitle.Disconnect)
        
        DispatchQueue.delay(0.5) {
            if Application.shared.status.isDisconnected() {
              //  Pinger.shared.ping()
               // Application.shared.settings.updateRandomServer()
            }
            
        }
    }
    
    
    func updateStatus(vpnStatus: NEVPNStatus, animated: Bool = true) {
        vpnStatusViewModel.status = vpnStatus
        controlPanelView.updateVPNStatus(viewModel: vpnStatusViewModel, animated: animated)
        controlPanelView.updateServerLabels(viewModel: vpnStatusViewModel)

//        if vpnStatus == .disconnected {
//            hud.dismiss()
//        }
//
//        if !needsToReconnect && !Application.shared.connectionManager.reconnectAutomatically && vpnStatus != lastVPNStatus && (vpnStatus == .invalid || vpnStatus == .disconnected) {
//            if Application.shared.connectionManager.isStatusStable && NetworkManager.shared.isNetworkReachable {
//                refreshServiceStatus()
//                NotificationCenter.default.post(name: Notification.Name.HideConnectToServerPopup, object: nil)
//            }
//        }
//
//        if vpnStatus != lastVPNStatus && (vpnStatus == .connected || vpnStatus == .disconnected) {
//            NotificationCenter.default.post(name: Notification.Name.HideConnectToServerPopup, object: nil)
//            DispatchQueue.delay(0.75) {
//                if Application.shared.connectionManager.isStatusStable && NetworkManager.shared.isNetworkReachable && !self.needsToReconnect && !Application.shared.connectionManager.reconnectAutomatically {
//                    self.reloadGeoLocation()
//                }
//            }
//        }
//
//        lastVPNStatus = vpnStatus
    }
    

    
    
    
    // MARK: - Observers -
    
    private func addObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(updateControlPanel), name: Notification.Name.UpdateControlPanel, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(serverSelected), name: Notification.Name.ServerSelected, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(connectionExecute), name: Notification.Name.Connect, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(disconnect), name: Notification.Name.Disconnect, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(protocolSelected), name: Notification.Name.ProtocolSelected, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reloadView), name: Notification.Name.AntiTrackerUpdated, object: nil)
    }
    
    // MARK: - Private methods -
    
    private func initView() {
        tableView.backgroundColor = ColorProvider.FloatyBackground
        tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 1))
        controlPanelView.updateServerNames()
        controlPanelView.updateServerLabels(viewModel: vpnStatusViewModel)

    }
    
    @objc private func reloadView() {
        tableView.reloadData()
        controlPanelView.updateServerNames()
        controlPanelView.updateServerLabels(viewModel: vpnStatusViewModel)

    }
    
    private func reloadGeoLocation() {
        NotificationCenter.default.post(name: Notification.Name.UpdateGeoLocation, object: nil)
    }
    
    @objc private func updateControlPanel() {
        reloadView()
        controlPanelView.updateVPNStatus(viewModel: vpnStatusViewModel)
    }
    
    @objc private func serverSelected() {

        controlPanelView.updateServerNames()
        controlPanelView.updateServerLabels(viewModel: vpnStatusViewModel)
    }
    
    @objc private func protocolSelected() {
//        Application.shared.connectionManager.needsToUpdateSelectedServer()
//        Application.shared.connectionManager.installOnDemandRules()

        tableView.reloadData()
    }

    
    
}


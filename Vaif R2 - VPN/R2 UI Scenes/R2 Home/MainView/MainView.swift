//
//  MainView.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 1/1/23.
//

import UIKit
import NetworkExtension
import SnapKit

class MainView: UIView {
    
    // MARK: - @IBOutlets -
    
    @IBOutlet weak var infoAlertView: InfoAlertView!
    @IBOutlet weak var mapScrollView: MapScrollView!
    //@IBOutlet weak var ipProtocolView: IpProtocolView!
    
    // MARK: - Properties -
    
    var ipv4ViewModel: ProofsViewModel! {
        didSet {
            mapScrollView.viewModel = ipv4ViewModel
            
            guard let model = ipv4ViewModel.model else {
                return
            }
            
            if Application.shared.connectionManager.status.isDisconnected() {
                localCoordinates = (model.latitude, model.longitude)
                mapScrollView.localCoordinates = (model.latitude, model.longitude)
            }
        }
    }
    
//    var ipv6ViewModel: ProofsViewModel! {
//        didSet {
//            ipProtocolView.update(ipv4ViewModel: ipv4ViewModel, ipv6ViewModel: ipv6ViewModel)
//        }
//    }
    
    var infoAlertViewModel = InfoAlertViewModel()
    private var localCoordinates: (Double, Double)?
    private var accountButton = UIButton()
    private var settingsButton = UIButton()
    private var centerMapButton = UIButton()
    
    // MARK: - @IBActions -
    
    
    // MARK: - View lifecycle -
    
    override func awakeFromNib() {
        backgroundColor = .backgroundColor()
        initSettingsAction()
//        initInfoAlert()
//        updateInfoAlert()
        addObservers()
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            centerMap()
        }
    }
    
    // MARK: - Methods -
    
    func setupView(animated: Bool = true) {
        setupConstraints()
        //updateInfoAlert()
        updateActionButtons()
        updateMapPosition(animated: animated)
        mapScrollView.updateMapMarkers()
    }
    
    func updateLayout() {
        setupConstraints()
        //updateInfoAlert()
        updateActionButtons()
        mapScrollView.updateMapPositionToCurrentCoordinates()
        mapScrollView.updateMapMarkers()
        //ipProtocolView.updateLayout()
    }
    
    func updateStatus(vpnStatus: NEVPNStatus) {
        mapScrollView.updateStatus(vpnStatus: vpnStatus)
    }
    
//    func updateInfoAlert() {
//        if infoAlertViewModel.shouldDisplay {
//            infoAlertView.show(viewModel: infoAlertViewModel)
//        } else {
//            infoAlertView.hide()
//        }
//
//        updateActionButtons()
//    }
    
    // MARK: - Private methods -
    
    private func addObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(centerMap), name: Notification.Name.CenterMap, object: nil)
    }
    
    private func initSettingsAction() {
        
        addSubview(centerMapButton)
        centerMapButton.setupIcon(imageName: "icon-crosshair")
        centerMapButton.accessibilityLabel = "Center map"
        centerMapButton.addTarget(self, action: #selector(centerMap), for: .touchUpInside)
    }
    
//    private func initInfoAlert() {
//        infoAlertView.delegate = infoAlertViewModel
//        bringSubviewToFront(infoAlertView)
//    }
    
    private func setupConstraints() {
        mapScrollView.setupConstraints()
    }
    
    private func updateMapPosition(animated: Bool = true) {
        let vpnStatus = Application.shared.connectionManager.status
        
        guard vpnStatus != .invalid else {
            return
        }
        
        mapScrollView.updateStatus(vpnStatus: vpnStatus)
    }
    
    private func updateActionButtons() {
        
        if UIDevice.current.userInterfaceIdiom == .pad && !UIApplication.shared.isSplitOrSlideOver {
            centerMapButton.snp.remakeConstraints { make in
                make.size.equalTo(42)
                make.right.equalTo(-170)
                make.top.equalTo(55)
            }
            return
        }
        
        var bottomOffset = 22
        
//        if infoAlertViewModel.shouldDisplay {
//            bottomOffset = 74
//        }
        
        if Application.shared.settings.connectionProtocol.tunnelType() != .ipsec && UserDefaults.shared.isMultiHop {
            centerMapButton.snp.remakeConstraints { make in
                make.size.equalTo(42)
                make.right.equalTo(-30)
                make.bottom.equalTo(-MapConstants.Container.bottomAnchorC - bottomOffset)
            }
            return
        }

        if Application.shared.settings.connectionProtocol.tunnelType() != .ipsec {
            centerMapButton.snp.remakeConstraints { make in
                make.size.equalTo(42)
                make.right.equalTo(-30)
                make.bottom.equalTo(-MapConstants.Container.bottomAnchorB - bottomOffset)
            }
            return
        }
        
        centerMapButton.snp.remakeConstraints { make in
            make.size.equalTo(42)
            make.right.equalTo(-30)
            make.bottom.equalTo(-MapConstants.Container.bottomAnchorA - bottomOffset)
        }
    }
    
    
    @objc private func centerMap() {
        mapScrollView.centerMap()
    }
    
}

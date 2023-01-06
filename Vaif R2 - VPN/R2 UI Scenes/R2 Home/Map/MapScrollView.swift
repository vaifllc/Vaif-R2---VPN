//
//  MapScrollView.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 1/3/23.
//


import UIKit
import NetworkExtension
import SnapKit

class MapScrollView: UIScrollView {
    
    // MARK: - @IBOutlets -
    
    
    @IBOutlet weak var mapImageView: UIImageView!
    
    // MARK: - Properties -
    
    var viewModel: ProofsViewModel! {
        didSet {
            if oldValue == nil {
                UIView.animate(withDuration: 0.65) {
                    self.alpha = 1
                }
            }
            
            markerLocalView.viewModel = viewModel
            
            if Application.shared.connectionManager.status.isDisconnected() {
                updateMapPosition(viewModel: viewModel, animated: oldValue != nil)
                markerGatewayView.hide(animated: true)
                markerLocalView.show(animated: oldValue != nil)
            }
        }
    }
    
    let markerLocalView = MapMarkerView(type: .local)
    let markerGatewayView = MapMarkerView(type: .gateway)
    var localCoordinates: (Double, Double)?
    var gatewayCoordinates: (Double, Double)?
    var currentCoordinates: (Double, Double)?
    
    private var connectToServerPopup = ConnectToServerPopupView()
    
    // MARK: - View lifecycle -
    
    override func awakeFromNib() {
        setupConstraints()
        setupView()
        initGestures()
        initServerLocationMarkers()
        initMarkers()
        initConnectToServerPopup()
        addObservers()
        updateAccessibility()
    }
    
    // MARK: - Methods -
    
    func setupConstraints() {
        if UIDevice.current.userInterfaceIdiom == .pad && UIApplication.shared.statusBarOrientation.isLandscape && !UIApplication.shared.isSplitOrSlideOver {
            snp.remakeConstraints { make in
                make.top.equalTo(MapConstants.Container.iPadLandscapeTopAnchor)
                make.left.equalTo(MapConstants.Container.iPadLandscapeLeftAnchor)
            }
        } else {
            snp.removeConstraints()
        }
    }
    
    func updateStatus(vpnStatus: NEVPNStatus) {
        var color = UIColor.backgroundColor()
        
        if vpnStatus == .connected {
            color = UIColor.init(named: Theme.ivpnGray24)!
        }
        
        UIView.animate(withDuration: 0.25) {
            self.backgroundColor = color
            self.mapImageView.backgroundColor = color
        }
        
        updateMapPosition(vpnStatus: vpnStatus)
        updateAccessibility()
    }
    
    func updateMapPositionToCurrentCoordinates() {
        if let currentCoordinates = currentCoordinates {
            updateMapPosition(latitude: currentCoordinates.0, longitude: currentCoordinates.1, isLocalPosition: false, updateMarkers: false)
        }
    }
    
    func centerMap() {
        if Application.shared.connectionManager.status.isDisconnected() {
            updateMapPositionToLocalCoordinates()
        } else {
            updateMapPositionToGatewayCoordinates()
        }
    }
    
    func updateMapMarkers() {
        markerLocalView.updateView()
        markerGatewayView.updateView()
    }
    
    func updateMapPosition(latitude: Double, longitude: Double, animated: Bool = false, isLocalPosition: Bool, updateMarkers: Bool = true) {
        let halfWidth = UIApplication.shared.isSplitOrSlideOver ? Double(frame.width / 2) : Double(UIScreen.main.bounds.width / 2)
        let halfHeight = UIApplication.shared.isSplitOrSlideOver ? Double(frame.height / 2) : Double(UIScreen.main.bounds.height / 2)
        let point = getCoordinatesBy(latitude: latitude, longitude: longitude)
        let bottomOffset = Double((MapConstants.Container.getBottomAnchor() / 2) - MapConstants.Container.getTopAnchor())
        let leftOffset = Double((MapConstants.Container.getLeftAnchor()) / 2)
        
        if animated {
            UIView.animate(withDuration: 0.55, delay: 0, options: .curveEaseInOut, animations: {
                self.setContentOffset(CGPoint(x: point.0 - halfWidth + leftOffset, y: point.1 - halfHeight + bottomOffset), animated: false)
            })
        } else {
            setContentOffset(CGPoint(x: point.0 - halfWidth + leftOffset, y: point.1 - halfHeight + bottomOffset), animated: false)
        }
        
        if updateMarkers {
            updateMarkerPosition(x: point.0 - 49, y: point.1 - 49, isLocalPosition: isLocalPosition)
        }
        
        currentCoordinates = (latitude, longitude)
    }
    
    // MARK: - Private methods -
    
    private func setupView() {
        isUserInteractionEnabled = true
        isScrollEnabled = true
        backgroundColor = .backgroundColor()
        contentInset = UIEdgeInsets(top: 0, left: 0, bottom: -875, right: 0)
        scrollsToTop = false
        mapImageView.tintColor = UIColor.init(named: Theme.ivpnGray23)
    }
    
    private func addObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(updateMapPositionToSelectedServer), name: Notification.Name.ShowConnectToServerPopup, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(hideConnectToServerPopup), name: Notification.Name.HideConnectToServerPopup, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reloadMarkers), name: Notification.Name.ServersListUpdated, object: nil)
    }
    
    private func initGestures() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        addGestureRecognizer(tap)
    }
    
    @objc private func handleTap() {
        hideConnectToServerPopup()
        NotificationCenter.default.post(name: Notification.Name.HideConnectionInfoPopup, object: nil)
    }
    
    private func initServerLocationMarkers() {
        for server in Application.shared.serverList.getServers() {
            placeMarker(latitude: server.latitude, longitude: server.longitude, city: server.city)
        }
        
        sendSubviewToBack(mapImageView)
    }
    
    private func initMarkers() {
        markerLocalView.hide()
        markerGatewayView.hide()
        addSubview(markerLocalView)
        addSubview(markerGatewayView)
    }
    
    private func initConnectToServerPopup() {
        addSubview(connectToServerPopup)
    }
    
    private func updateMapPosition(vpnStatus: NEVPNStatus, animated: Bool = true) {
        markerGatewayView.status = vpnStatus
        
        if vpnStatus == .connecting || vpnStatus == .connected {
            updateMapPositionToGateway(animated: animated)
            return
        }
        
        if vpnStatus == .disconnecting && !Application.shared.connectionManager.reconnectAutomatically {
            updateMapPositionToLocalCoordinates(animated: animated)
            return
        }
        
        if vpnStatus == .disconnecting && Application.shared.connectionManager.reconnectAutomatically {
            markerGatewayView.hide(animated: true)
            return
        }
    }
    
    private func updateMapPosition(viewModel: ProofsViewModel, animated: Bool = false) {
        updateMapPosition(latitude: viewModel.latitude, longitude: viewModel.longitude, animated: animated, isLocalPosition: true)
    }
    
    private func updateMapPositionToGateway(animated: Bool = true) {
        var server = Application.shared.settings.selectedServer
        
        if Application.shared.settings.connectionProtocol.tunnelType() != .ipsec && UserDefaults.shared.isMultiHop {
            server = Application.shared.settings.selectedExitServer
        }
        
        gatewayCoordinates = (server.latitude, server.longitude)
        updateMapPosition(latitude: server.latitude, longitude: server.longitude, animated: animated, isLocalPosition: false)
        markerLocalView.hide(animated: animated)
        DispatchQueue.delay(0.25) {
            let model = GeoLookup(ipAddress: server.ipAddresses.first ?? "", countryCode: server.countryCode, country: server.country, city: server.city, isIvpnServer: true, isp: "", latitude: server.latitude, longitude: server.longitude)
            self.markerGatewayView.viewModel = ProofsViewModel(model: model)
            self.markerGatewayView.show(animated: animated)
            self.markerLocalView.hide(animated: false)
            self.updateAccessibility()
        }
    }
    
    private func updateMapPositionToGatewayCoordinates(animated: Bool = true) {
        if let gatewayCoordinates = gatewayCoordinates {
            updateMapPosition(latitude: gatewayCoordinates.0, longitude: gatewayCoordinates.1, animated: animated, isLocalPosition: false)
        }
    }
    
    private func updateMapPositionToLocalCoordinates(animated: Bool = true) {
        if let localCoordinates = localCoordinates {
            updateMapPosition(latitude: localCoordinates.0, longitude: localCoordinates.1, animated: animated, isLocalPosition: true)
            markerGatewayView.hide(animated: true)
            DispatchQueue.delay(0.25) {
                self.markerLocalView.show(animated: true)
                self.markerGatewayView.hide(animated: false)
            }
        }
    }
    
    private func updateMarkerPosition(x: Double, y: Double, isLocalPosition: Bool) {
        if isLocalPosition {
            markerLocalView.snp.updateConstraints { make in
                make.left.equalTo(x)
                make.top.equalTo(y)
            }
            
            UIView.animate(withDuration: 0.15) {
                self.layoutIfNeeded()
            }
        } else {
            markerGatewayView.snp.updateConstraints { make in
                make.left.equalTo(x)
                make.top.equalTo(y)
            }
            
            UIView.animate(withDuration: 0.15) {
                self.layoutIfNeeded()
            }
        }
    }
    
    private func placeMarker(latitude: Double, longitude: Double, city: String) {
        let point = getCoordinatesBy(latitude: latitude, longitude: longitude)
        
        let button = UIButton(frame: CGRect(x: point.0 - 50, y: point.1 - 21, width: 100, height: 20))
        button.setTitle(city, for: .normal)
        button.setTitleColor(UIColor.init(named: Theme.ivpnGray21), for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 10, weight: .regular)
        button.addTarget(self, action: #selector(selectServer), for: .touchUpInside)
        button.tag = 1
        
        let marker = UIView(frame: CGRect(x: 50 - 3, y: 18, width: 6, height: 6))
        marker.layer.cornerRadius = 3
        marker.backgroundColor = UIColor.init(named: Theme.ivpnGray21)
        
        if city == "Bratislava" {
            button.titleEdgeInsets = UIEdgeInsets(top: 21, left: 59, bottom: 0, right: 0)
            button.frame = CGRect(x: point.0 - 55, y: point.1 - 21, width: 110, height: 20)
            marker.frame = CGRect(x: 55 - 3, y: 18, width: 6, height: 6)
        }

        if city == "Budapest" {
            button.titleEdgeInsets = UIEdgeInsets(top: 21, left: 58, bottom: 0, right: 0)
            button.frame = CGRect(x: point.0 - 55, y: point.1 - 21, width: 110, height: 20)
            marker.frame = CGRect(x: 55 - 3, y: 18, width: 6, height: 6)
        }
        
        if city == "New Jersey, NJ" {
            button.titleEdgeInsets = UIEdgeInsets(top: 22, left: 93, bottom: 0, right: 0)
            button.frame = CGRect(x: point.0 - 85, y: point.1 - 21, width: 170, height: 20)
            marker.frame = CGRect(x: 85 - 3, y: 18, width: 6, height: 6)
        }
        
        button.addSubview(marker)
        button.isAccessibilityElement = true
        addSubview(button)
        sendSubviewToBack(button)
    }
    
    private func removeMarkers() {
        subviews.forEach {
            if $0.tag == 1 {
                $0.removeFromSuperview()
            }
        }
    }
    
    @objc private func reloadMarkers() {
        removeMarkers()
        initServerLocationMarkers()
    }
    
    @objc private func selectServer(_ sender: UIButton) {
        let city = sender.titleLabel?.text ?? ""
        
        if let server = Application.shared.serverList.getServer(byCity: city) {
            showConnectToServerPopup(server: server)
            updateMapPosition(latitude: server.latitude, longitude: server.longitude, animated: true, isLocalPosition: false, updateMarkers: false)
            
            if Application.shared.connectionManager.status.isDisconnected() && Application.shared.serverList.validateServer(firstServer: Application.shared.settings.selectedServer, secondServer: server) {
                
                if UserDefaults.shared.isMultiHop {
                    Application.shared.settings.selectedExitServer = server
                    Application.shared.settings.selectedExitServer.fastest = false
                    Application.shared.settings.selectedExitHost = nil
                } else {
                    Application.shared.settings.selectedServer = server
                    Application.shared.settings.selectedServer.fastest = false
                    Application.shared.settings.selectedHost = nil
                }
                
                Application.shared.connectionManager.needsToUpdateSelectedServer()
                Application.shared.connectionManager.installOnDemandRules()
                NotificationCenter.default.post(name: Notification.Name.ServerSelected, object: nil)
            }
        }
    }
    
    @objc private func updateMapPositionToSelectedServer() {
        guard Application.shared.connectionManager.status.isDisconnected() else {
            return
        }
        
        let server = UserDefaults.shared.isMultiHop ? Application.shared.settings.selectedExitServer : Application.shared.settings.selectedServer
        
        guard !server.random else {
            NotificationCenter.default.post(name: Notification.Name.CenterMap, object: nil)
            return
        }
        
        showConnectToServerPopup(server: server)
        updateMapPosition(latitude: server.latitude, longitude: server.longitude, animated: true, isLocalPosition: false, updateMarkers: false)
    }
    
    private func showConnectToServerPopup(server: ServerModel) {
        let point = getCoordinatesBy(latitude: server.latitude, longitude: server.longitude)
        connectToServerPopup.snp.updateConstraints { make in
            make.left.equalTo(point.0 - 135)
            make.top.equalTo(point.1 + 17)
        }
        
        let nearByServers = getNearByServers(server: server)
        connectToServerPopup.servers = nearByServers
        connectToServerPopup.vpnServer = nearByServers.first ?? server
        connectToServerPopup.show()
        NotificationCenter.default.post(name: Notification.Name.HideConnectionInfoPopup, object: nil)
    }
    
    private func getNearByServers(server selectedServer: ServerModel) -> [ServerModel] {
        var servers = Application.shared.serverList.validateServer(firstServer: Application.shared.settings.selectedServer, secondServer: selectedServer) ? [selectedServer] : []
        
        for server in Application.shared.serverList.getServers() {
            guard server !== selectedServer else { continue }
            guard Application.shared.serverList.validateServer(firstServer: Application.shared.settings.selectedServer, secondServer: server) else { continue }
            
            if isNearByServer(selectedServer, server) {
                servers.append(server)
            }
        }
        
        return servers
    }
    
    private func isNearByServer(_ server1: ServerModel, _ server2: ServerModel) -> Bool {
        let point1 = getCoordinatesBy(latitude: server1.latitude, longitude: server1.longitude)
        let point2 = getCoordinatesBy(latitude: server2.latitude, longitude: server2.longitude)
        
        let diffX = abs(point1.0 - point2.0)
        let diffY = abs(point1.1 - point2.1)
        
        if diffX < 60 && diffY < 18 {
            return true
        }
        
        return false
    }
    
    @objc private func hideConnectToServerPopup() {
        connectToServerPopup.hide()
    }
    
    private func getCoordinatesBy(latitude: Double, longitude: Double) -> (Double, Double) {
        let bitmapWidth: Double = 5400
        let bitmapHeight: Double = 3942
        
        var x: Double = longitude.toRadian() - 0.18
        var y: Double = latitude.toRadian()
        
        let yStrech = 0.542
        let yOffset = 0.053
        
        y = yStrech * Darwin.log(tan(0.25 * Double.pi + 0.4 * y)) + yOffset
        
        x = ((bitmapWidth) / 2) + (bitmapWidth / (2 * Double.pi)) * x
        y = (bitmapHeight / 2) - (bitmapHeight / 2) * y
        
        return (x, y)
    }
    
    private func updateAccessibility() {
        let isDisconnected = Application.shared.connectionManager.status.isDisconnected()
        markerLocalView.accessibilityLabel = "Your status is - disconnected"
        markerLocalView.isAccessibilityElement = isDisconnected
        markerGatewayView.accessibilityLabel = "Your status is - connected to \(markerGatewayView.viewModel?.model?.city ?? "")"
        markerGatewayView.isAccessibilityElement = !isDisconnected
        markerLocalView.tag = 100
        markerGatewayView.tag = 200
        accessibilityElements = [UIView]()
        for subview in subviews where subview.isAccessibilityElement {
            accessibilityElements?.append(subview)
        }
        for subview in connectToServerPopup.container.subviews where subview.isAccessibilityElement {
            accessibilityElements?.append(subview)
        }
        if isDisconnected {
            for subview in markerLocalView.connectionInfoPopup.container.subviews where subview.isAccessibilityElement {
                accessibilityElements?.append(subview)
            }
        }
        if !isDisconnected {
            for subview in markerGatewayView.connectionInfoPopup.container.subviews where subview.isAccessibilityElement {
                accessibilityElements?.append(subview)
            }
        }
        accessibilityElements?.sort(by: {($0 as AnyObject).tag > ($1 as AnyObject).tag})
    }
    
}


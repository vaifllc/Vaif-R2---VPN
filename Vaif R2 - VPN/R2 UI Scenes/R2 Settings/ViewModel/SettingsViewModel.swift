//
//  SettingsViewModel.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 12/28/22.
//

import UIKit
import FirebaseAuth

final class SettingsViewModel {
    typealias Factory = AppStateManagerFactory &
    AppSessionManagerFactory &
    CoreAlertServiceFactory &
    SettingsServiceFactory &
    //                        ConnectionStatusServiceFactory &
    PropertiesManagerFactory &
    AppInfoFactory &
    AuthKeychainHandleFactory
    
    private let factory: Factory
    
    private let maxCharCount = 20
    private lazy var propertiesManager: PropertiesManagerProtocol = factory.makePropertiesManager()
    private lazy var appSessionManager: AppSessionManager = factory.makeAppSessionManager()
    private lazy var appStateManager: AppStateManager = factory.makeAppStateManager()
    private lazy var alertService: AlertService = factory.makeCoreAlertService()
    private lazy var settingsService: SettingsService = factory.makeSettingsService()
    //private lazy var connectionStatusService: ConnectionStatusService = factory.makeConnectionStatusService()
    private lazy var appInfo: AppInfo = factory.makeAppInfo()
    private lazy var authKeychain: AuthKeychainHandle = factory.makeAuthKeychainHandle()
    //private let protocolService: ProtocolService
    private lazy var navigationService: NavigationService = container.makeNavigationService()
    private let container = DependencyContainer()
    var reloadNeeded: (() -> Void)?
    public var readyGroup: DispatchGroup? = DispatchGroup()
    
    //    private var vpnGateway: VpnGatewayProtocol?
    //    private var profileManager: ProfileManager?
    //    private var serverManager: ServerManager?
    
    var pushHandler: ((UIViewController) -> Void)?
    
    init(factory: Factory) {
        self.factory = factory
        //self.protocolService = protocolService
        
        startObserving()
    }
    
    var tableViewData: [TableViewSection] {
        var sections: [TableViewSection] = []
        
        sections.append(accountSection)
       // sections.append(securitySection)
        //sections.append(advancedSection)
        
        if let connectionSection = connectionSection {
            sections.append(connectionSection)
        }
        sections.append(extensionsSection)
        if let batterySection = batterySection {
            sections.append(batterySection)
        }
        sections.append(logSection)
        sections.append(bottomSection)
        
        return sections
    }
    
    var isSessionEstablished: Bool {
        return appSessionManager.sessionStatus == .established
    }
    
    var isConnected: Bool {
        return false
        //        guard let vpnGateway = vpnGateway else {
        //            return false
        //        }
        //        return vpnGateway.connection == .connected
    }
    
    var isStateStable: Bool {
        return false
        //        guard let vpnGateway = vpnGateway else {
        //            return false
        //        }
        //        return vpnGateway.connection == .connected || vpnGateway.connection == .disconnected
    }
    
    // MARK: - Header section
    func viewForFooter() -> UIView {
        let view = AppVersionView.loadViewFromNib() as AppVersionView
        view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50)
        view.appVersionLabel.text = "Version" + " \(appInfo.bundleShortVersion) (\(appInfo.bundleVersion))"
        return view
    }
    
    // MARK: - Private functions
    private func startObserving() {
//                NotificationCenter.default.addObserver(self, selector: #selector(sessionChanged),
//                                                       name: appSessionManager.sessionChanged, object: nil)
//                NotificationCenter.default.addObserver(self, selector: #selector(reload),
//                                                       name: type(of: netShieldPropertyProvider).netShieldNotification, object: nil)
                NotificationCenter.default.addObserver(self, selector: #selector(reload),
                                                       name: type(of: propertiesManager).vpnAcceleratorNotification, object: nil)
                NotificationCenter.default.addObserver(self, selector: #selector(reload),
                                                       name: appSessionManager.dataReloaded, object: nil)
//                NotificationCenter.default.addObserver(self, selector: #selector(reload),
//                                                       name: type(of: natTypePropertyProvider).natTypeNotification, object: nil)
                NotificationCenter.default.addObserver(self, selector: #selector(reload),
                                                       name: type(of: propertiesManager).featureFlagsNotification, object: nil)
//                NotificationCenter.default.addObserver(self, selector: #selector(reload),
//                                                       name: type(of: safeModePropertyProvider).safeModeNotification, object: nil)
//                NotificationCenter.default.addObserver(self, selector: #selector(reload),
//                                                       name: type(of: vpnKeychain).vpnCredentialsChanged, object: nil)
    }
    
    
    @objc private func reload() {
        reloadNeeded?()
    }
    
    private var accountSection: TableViewSection {
        let username: String
        let accountPlanName: String
        
        let active = StoreKit.shared.isActivePaidSubscription()
        if active {
            let user = WitWork.shared.user
            let paidSubscription = WitWork.shared.getSubscription()
            let date = paidSubscription!.expiresDate
            print("expired at: \(date)")
            let dateStr = date.toFormat("YYYY/MM/dd", locale: nil)
            accountPlanName = "VIP package until \(dateStr)"
            username = (user?.email!.description)!
        }else {
            accountPlanName = "Free R1 Account"
        }
        
        
        let cell = TableViewCellModel.pushAccountDetails(
            initials: NSAttributedString(string: (WitWork.shared.user?.email!.initials())!, attributes: .CaptionStrong),
            username: NSAttributedString(string: (WitWork().user?.email)!, attributes: .DefaultSmall),
            plan: NSAttributedString(string: accountPlanName, attributes: .CaptionWeak)
        ) { [weak self] in
            self?.pushSettingsAccountViewController()
        }
        
        return TableViewSection(title: "Account", cells: [cell])
    }
    
    private var securitySection: TableViewSection {
        //let vpnProtocol = propertiesManager.vpnProtocol
        
        var cells: [TableViewCellModel] = []
        
        //        let protocolValue = propertiesManager.smartProtocol ? LocalizedString.smartTitle : vpnProtocol.localizedString
        //        cells.append(.pushKeyValue(key: LocalizedString.protocol, value: protocolValue, handler: { [weak self] in
        //            self?.pushProtocolViewController()
        //        }))
        cells.append(.tooltip(text: LocalizedString.smartProtocolDescription))
        
        let netShieldAvailable = propertiesManager.featureFlags.netShield
        //        if netShieldAvailable {
        //            cells.append(.pushKeyValue(key: LocalizedString.netshieldTitle, value: netShieldPropertyProvider.netShieldType.name, handler: { [weak self] in
        //                guard let self = self else {
        //                    return
        //                }
        //
        //                self.pushNetshieldSelectionViewController(selectedFeature: self.netShieldPropertyProvider.netShieldType, shouldSelectNewValue: { [weak self] type, approve in
        //                    self?.vpnStateConfiguration.getInfo { [weak self] info in
        //                        switch VpnFeatureChangeState(state: info.state, vpnProtocol: info.connection?.vpnProtocol) {
        //                        case .withConnectionUpdate:
        //                            approve()
        //                            self?.vpnManager.set(netShieldType: type)
        //                        case .withReconnect:
        //                            self?.alertService.push(alert: ReconnectOnNetshieldChangeAlert(isOn: type != .off, continueHandler: { [weak self] in
        //                                approve()
        //                                log.info("Connection will restart after VPN feature change", category: .connectionConnect, event: .trigger, metadata: ["feature": "netShieldType"])
        //                                self?.vpnGateway?.reconnect(with: type)
        //                                self?.connectionStatusService.presentStatusViewController()
        //                            }))
        //                        case .immediately:
        //                            approve()
        //                        }
        //                    }
        //                }, onFeatureChange: { [weak self] type in
        //                    self?.netShieldPropertyProvider.netShieldType = type
        //                })
        //            }))
                    cells.append(.tooltip(text: LocalizedString.netshieldTitleTooltip))
        //        }
        
        cells.append(.toggle(title: LocalizedString.alwaysOnVpn, on: { true }, enabled: false, handler: nil))
        cells.append(.tooltip(text: LocalizedString.alwaysOnVpnTooltipIos))
        
        if #available(iOS 14, *) {
            cells.append(.toggle(title: LocalizedString.killSwitch, on: { [unowned self] in self.propertiesManager.killSwitch }, enabled: true, handler: nil))
            cells.append(.tooltip(text: LocalizedString.killSwitchTooltip))
        }
        
        return TableViewSection(title: LocalizedString.securityOptions, cells: cells)
    }
    
    //    private var vpnAcceleratorSection: [TableViewCellModel] {
    //        return [
    //            .toggle(title: LocalizedString.vpnAcceleratorTitle, on: { [unowned self] in self.propertiesManager.vpnAcceleratorEnabled }, enabled: true, handler: { (toggleOn, callback)  in
    //                self.vpnStateConfiguration.getInfo { info in
    //                    switch VpnFeatureChangeState(state: info.state, vpnProtocol: info.connection?.vpnProtocol) {
    //                    case .withConnectionUpdate:
    //                        self.propertiesManager.vpnAcceleratorEnabled.toggle()
    //                        self.vpnManager.set(vpnAccelerator: self.propertiesManager.vpnAcceleratorEnabled)
    //                        callback(self.propertiesManager.vpnAcceleratorEnabled)
    //                    case .withReconnect:
    //                        self.alertService.push(alert: ReconnectOnActionAlert(actionTitle: LocalizedString.vpnAcceleratorChangeTitle, confirmHandler: {
    //                            self.propertiesManager.vpnAcceleratorEnabled.toggle()
    //                            callback(self.propertiesManager.vpnAcceleratorEnabled)
    //                            log.info("Connection will restart after VPN feature change", category: .connectionConnect, event: .trigger, metadata: ["feature": "vpnAccelerator"])
    //                            self.vpnGateway?.retryConnection()
    //                        }))
    //                    case .immediately:
    //                        self.propertiesManager.vpnAcceleratorEnabled.toggle()
    //                        callback(self.propertiesManager.vpnAcceleratorEnabled)
    //                    }
    //                }
    //            }),
    //            .attributedTooltip(text: NSMutableAttributedString(attributedString: LocalizedString.vpnAcceleratorDescription.attributed(withColor: UIColor.weakTextColor(), fontSize: 13)).add(link: LocalizedString.vpnAcceleratorDescriptionAltLink, withUrl: CoreAppConstants.ProtonVpnLinks.vpnAccelerator))
    //        ]
    //    }
    
    private var allowLanSection: [TableViewCellModel] {
        return [
            .toggle(title: LocalizedString.allowLanTitle, on: { [unowned self] in self.propertiesManager.excludeLocalNetworks }, enabled: true, handler: nil),
            .tooltip(text: LocalizedString.allowLanInfo)
        ]
    }
    
    //    private var moderateNATSection: [TableViewCellModel] {
    //        return [
    //            .toggle(title: LocalizedString.moderateNatTitle, on: { [unowned self] in self.natTypePropertyProvider.natType == .moderateNAT }, enabled: true, handler: { [weak self] (toggleOn, callback) in
    //                guard let self = self, self.natTypePropertyProvider.isUserEligibleForNATTypeChange else {
    //                    callback(!toggleOn)
    //                    self?.alertService.push(alert: ModerateNATUpsellAlert())
    //                    return
    //                }
    //
    //                let natType = toggleOn ? NATType.moderateNAT: NATType.strictNAT
    //
    //                self.vpnStateConfiguration.getInfo { [weak self] info in
    //                    switch VpnFeatureChangeState(state: info.state, vpnProtocol: info.connection?.vpnProtocol) {
    //                    case .withConnectionUpdate:
    //                        self?.natTypePropertyProvider.natType = natType
    //                        self?.vpnManager.set(natType: natType)
    //                        callback(toggleOn)
    //                    case .withReconnect:
    //                        self?.alertService.push(alert: ReconnectOnActionAlert(actionTitle: LocalizedString.moderateNatChangeTitle, confirmHandler: { [weak self] in
    //                            self?.natTypePropertyProvider.natType = natType
    //                            callback(toggleOn)
    //                            log.info("Connection will restart after VPN feature change", category: .connectionConnect, event: .trigger, metadata: ["feature": "natType"])
    //                            self?.vpnGateway?.retryConnection()
    //                        }))
    //                    case .immediately:
    //                        self?.natTypePropertyProvider.natType = natType
    //                        callback(toggleOn)
    //                    }
    //                }
    //            }),
    //            .attributedTooltip(text: NSMutableAttributedString(attributedString: LocalizedString.moderateNatExplanation.attributed(withColor: UIColor.weakTextColor(), fontSize: 13)).add(link: LocalizedString.moderateNatExplanationLink, withUrl: CoreAppConstants.ProtonVpnLinks.moderateNAT))
    //        ]
    //    }
    
    //    private var safeModeSection: [TableViewCellModel] {
    //        // the UI shows the "opposite" value of the safe mode flag
    //        // if safe mode is enabled the moderate nat checkbox is unchecked and vice versa
    //        return [
    //            .toggle(title: LocalizedString.nonStandardPortsTitle, on: { [unowned self] in self.safeModePropertyProvider.safeMode == false }, enabled: true, handler: { [unowned self] (toggleOn, callback) in
    //
    //                guard self.safeModePropertyProvider.isUserEligibleForSafeModeChange else {
    //                    callback(!toggleOn)
    //                    self.alertService.push(alert: SafeModeUpsellAlert())
    //                    return
    //                }
    //
    //                let currentSafeMode = self.safeModePropertyProvider.safeMode ?? true
    //                let newSafeMode = !currentSafeMode
    //
    //                self.vpnStateConfiguration.getInfo { info in
    //                    switch VpnFeatureChangeState(state: info.state, vpnProtocol: info.connection?.vpnProtocol) {
    //                    case .withConnectionUpdate:
    //                        self.safeModePropertyProvider.safeMode = newSafeMode
    //                        self.vpnManager.set(safeMode: newSafeMode)
    //                        callback(toggleOn)
    //                    case .withReconnect:
    //                        self.alertService.push(alert: ReconnectOnActionAlert(actionTitle: LocalizedString.nonStandardPortsChangeTitle, confirmHandler: {
    //                            self.safeModePropertyProvider.safeMode = newSafeMode
    //                            callback(toggleOn)
    //                            log.info("Connection will restart after VPN feature change", category: .connectionConnect, event: .trigger, metadata: ["feature": "safeMode"])
    //                            self.vpnGateway?.retryConnection()
    //                        }))
    //                    case .immediately:
    //                        self.safeModePropertyProvider.safeMode = newSafeMode
    //                        callback(toggleOn)
    //                    }
    //                }
    //            }),
    //            .attributedTooltip(text: NSMutableAttributedString(attributedString: LocalizedString.nonStandardPortsExplanation.attributed(withColor: UIColor.weakTextColor(), fontSize: 13)).add(link: LocalizedString.nonStandardPortsExplanationLink, withUrl: CoreAppConstants.ProtonVpnLinks.safeMode))
    //        ]
    //    }
    
    private var alternativeRoutingSection: [TableViewCellModel] {
        return [
            .toggle(title: LocalizedString.troubleshootItemAltTitle, on: { [unowned self] in self.propertiesManager.alternativeRouting }, enabled: true, handler: { [unowned self] (toggleOn, callback) in
                self.propertiesManager.alternativeRouting.toggle()
                callback(self.propertiesManager.alternativeRouting)
            }),
            .attributedTooltip(text: NSMutableAttributedString(attributedString: LocalizedString.troubleshootItemAltDescription.attributed(withColor: UIColor.weakTextColor(), fontSize: 13)).add(link: LocalizedString.troubleshootItemAltLink1, withUrl: CoreAppConstants.ProtonVpnLinks.alternativeRouting))
        ]
    }
    
    private var advancedSection: TableViewSection {
        var cells: [TableViewCellModel] = alternativeRoutingSection
        
        //        if safeModePropertyProvider.safeModeFeatureEnabled {
        //            cells.append(contentsOf: safeModeSection)
        //        }
        //
        //        if propertiesManager.featureFlags.moderateNAT {
        //            cells.append(contentsOf: moderateNATSection)
        //        }
        
        return TableViewSection(title: LocalizedString.advanced, cells: cells)
    }
    
    private var connectionSection: TableViewSection? {
        var cells: [TableViewCellModel] = []
        
        //        if propertiesManager.featureFlags.vpnAccelerator {
        //            cells.append(contentsOf: vpnAcceleratorSection)
        //        }
        
        if #available(iOS 14.2, *) {
            cells.append(contentsOf: allowLanSection)
        }
        
        return cells.isEmpty ? nil : TableViewSection(title: LocalizedString.connection, cells: cells)
    }
    
    //    private func switchLANCallback () -> ((Bool, @escaping (Bool) -> Void) -> Void) {
    //        return { (toggleOn, callback) in
    //            let isConnected = self.vpnGateway?.connection == .connected || self.vpnGateway?.connection == .connecting
    //
    //            var alert: SystemAlert
    //
    //            if self.propertiesManager.killSwitch, !self.propertiesManager.excludeLocalNetworks {
    //                alert = AllowLANConnectionsAlert(connected: isConnected) {
    //                    self.propertiesManager.excludeLocalNetworks = true
    //                    self.propertiesManager.killSwitch = false
    //                    if isConnected {
    //                        log.info("Connection will restart after VPN feature change", category: .connectionConnect, event: .trigger, metadata: ["feature": "excludeLocalNetworks", "feature_additional": "killSwitch"])
    //                        self.vpnGateway?.retryConnection()
    //                    }
    //                    self.reloadNeeded?()
    //                    callback(true)
    //                } cancelHandler: {
    //                    callback(false)
    //                }
    //            } else if isConnected {
    //                alert = ReconnectOnSettingsChangeAlert(confirmHandler: {
    //                    self.propertiesManager.excludeLocalNetworks.toggle()
    //                    log.info("Connection will restart after VPN feature change", category: .connectionConnect, event: .trigger, metadata: ["feature": "excludeLocalNetworks"])
    //                    self.vpnGateway?.retryConnection()
    //                    callback(self.propertiesManager.excludeLocalNetworks)
    //                }, cancelHandler: {
    //                    callback(self.propertiesManager.excludeLocalNetworks)
    //                })
    //            } else {
    //                self.propertiesManager.excludeLocalNetworks.toggle()
    //                callback(self.propertiesManager.excludeLocalNetworks)
    //                return
    //            }
    //
    //            self.alertService.push(alert: alert)
    //        }
    //    }
    
    //    private func ksSwitchCallback () -> ((Bool, @escaping (Bool) -> Void) -> Void) {
    //        return { (toggleOn, callback) in
    //            let isConnected = self.vpnGateway?.connection == .connected || self.vpnGateway?.connection == .connecting
    //
    //            var alert: SystemAlert
    //
    //            if self.propertiesManager.excludeLocalNetworks, !self.propertiesManager.killSwitch {
    //                alert = TurnOnKillSwitchAlert {
    //                    self.propertiesManager.excludeLocalNetworks = false
    //                    self.propertiesManager.killSwitch = true
    //                    if isConnected {
    //                        log.info("Connection will restart after VPN feature change", category: .connectionConnect, event: .trigger, metadata: ["feature": "killSwitch", "feature_additional": "excludeLocalNetworks"])
    //                        self.vpnGateway?.retryConnection()
    //                    }
    //                    self.reloadNeeded?()
    //                    callback(true)
    //                } cancelHandler: {
    //                    callback(false)
    //                }
    //            } else if isConnected {
    //                alert = ReconnectOnSettingsChangeAlert(confirmHandler: {
    //                    self.propertiesManager.killSwitch.toggle()
    //                    log.info("Connection will restart after VPN feature change", category: .connectionConnect, event: .trigger, metadata: ["feature": "killSwitch"])
    //                    self.vpnGateway?.retryConnection()
    //                    callback(self.propertiesManager.killSwitch)
    //                }, cancelHandler: {
    //                    callback(self.propertiesManager.killSwitch)
    //                })
    //            } else {
    //                self.propertiesManager.killSwitch.toggle()
    //                callback(self.propertiesManager.killSwitch)
    //                return
    //            }
    //
    //            self.alertService.push(alert: alert)
    //        }
    //    }
    
    private var extensionsSection: TableViewSection {
        let cells: [TableViewCellModel] = [
            .pushStandard(title: LocalizedString.widget, handler: { [pushExtensionsViewController] in
                pushExtensionsViewController()
            })
        ]
        
        return TableViewSection(title: LocalizedString.extensions, cells: cells)
    }
    
    private var batterySection: TableViewSection? {
        switch Application.shared.settings.connectionProtocol {
        case .ipsec:
            return nil
        default:
            return TableViewSection(title: "", cells: [
                .pushStandard(title: LocalizedString.batteryTitle, handler: { [pushBatteryViewController] in
                    pushBatteryViewController()
                })
            ])
        }
    }
    
    private var logSection: TableViewSection {
        let cells: [TableViewCellModel] = [
            .pushStandard(title: LocalizedString.viewLogs, handler: { [pushLogSelectionViewController] in
                pushLogSelectionViewController()
            })
        ]
        
        return TableViewSection(title: "", cells: cells)
    }
    
    private var bottomSection: TableViewSection {
        let cells: [TableViewCellModel] = [
            .button(title: LocalizedString.reportBug, accessibilityIdentifier: "Report Bug", color: .normalTextColor(), handler: { [reportBug] in
                reportBug()
            }),
            .button(title: LocalizedString.logOut, accessibilityIdentifier: "Log Out", color: .notificationErrorColor(), handler: { [logOut] in
                logOut()
            })
        ]
        
        return TableViewSection(title: "", cells: cells)
    }
    
    private func formQuickActionDescription() -> String? {
        //        guard isSessionEstablished, let vpnGateway = vpnGateway else {
        //            return nil
        //        }
        
        let description: String
        description = LocalizedString.disconnect
        //        switch vpnGateway.connection {
        //        case .connected, .disconnecting:
        //            description = LocalizedString.disconnect
        //        case .disconnected, .connecting:
        //            description = LocalizedString.quickConnect
        //        }
        return description
    }
    
    private func pushSettingsAccountViewController() {
        //        guard let pushHandler = pushHandler, let accountViewController = settingsService.makeSettingsAccountViewController() else {
        //            return
        //        }
        //        pushHandler(accountViewController)
    }
    
    //    private func pushProtocolViewController() {
    //        let vpnProtocolViewModel = VpnProtocolViewModel(connectionProtocol: propertiesManager.connectionProtocol, featureFlags: propertiesManager.featureFlags)
    //        vpnProtocolViewModel.protocolChangeConfirmation = { [self] completion in
    //            if self.appStateManager.state.isSafeToEnd {
    //                completion(true)
    //                return
    //            }
    //
    //            let alert = ChangeProtocolDisconnectAlert {
    //                log.debug("Disconnect requested after changing protocol", category: .connectionDisconnect, event: .trigger)
    //                completion(true)
    //            }
    //            alert.dismiss = { completion(false) }
    //            self.alertService.push(alert: alert)
    //        }
    //        vpnProtocolViewModel.protocolChanged = { [self] connectionProtocol in
    //            switch connectionProtocol {
    //            case .smartProtocol:
    //                self.propertiesManager.smartProtocol = true
    //            case .vpnProtocol(let vpnProtocol):
    //                self.propertiesManager.smartProtocol = false
    //                self.propertiesManager.vpnProtocol = vpnProtocol
    //            }
    //
    //            if !self.appStateManager.state.isSafeToEnd {
    //                self.vpnGateway?.reconnect(with: connectionProtocol)
    //            }
    //        }
    //        pushHandler?(protocolService.makeVpnProtocolViewController(viewModel: vpnProtocolViewModel))
    //    }
    
    private func pushExtensionsViewController() {
        // pushHandler?(settingsService.makeExtensionsSettingsViewController())
    }
    
    private func pushBatteryViewController() {
        pushHandler?(settingsService.makeBatteryUsageViewController())
    }
    
    private func pushLogSelectionViewController() {
        pushHandler?(settingsService.makeLogSelectionViewController())
    }
    
    //    private func pushNetshieldSelectionViewController(selectedFeature: NetShieldType, shouldSelectNewValue: @escaping PaidFeatureSelectionViewModel<NetShieldType>.ApproveCallback, onFeatureChange: @escaping PaidFeatureSelectionViewModel<NetShieldType>.FeatureChangeCallback) {
    //        pushHandler?(makePaidFeatureSelectionViewController(title: LocalizedString.netshieldTitle, allFeatures: NetShieldType.allCases, selectedFeature: selectedFeature, shouldSelectNewValue: shouldSelectNewValue, onFeatureChange: onFeatureChange))
    //    }
    
    //    private func makePaidFeatureSelectionViewController<T>(title: String, allFeatures: [T], selectedFeature: T, shouldSelectNewValue: @escaping PaidFeatureSelectionViewModel<T>.ApproveCallback, onFeatureChange: @escaping PaidFeatureSelectionViewModel<T>.FeatureChangeCallback) -> PaidFeatureSelectionViewController<T> where T: PaidFeature {
    //        let viewModel = PaidFeatureSelectionViewModel(title: title, allFeatures: allFeatures, selectedFeature: selectedFeature, factory: factory, shouldSelectNewValue: shouldSelectNewValue, onFeatureChange: onFeatureChange)
    //        return PaidFeatureSelectionViewController(viewModel: viewModel)
    //    }
    
    private func reportBug() {
        settingsService.presentReportBug()
    }
    
    public func whenReady(queue: DispatchQueue, completion: @escaping () -> Void) {
        self.readyGroup?.notify(queue: queue) {
            completion()
            self.readyGroup = nil
        }
    }
    
    private func logOut() {
        self.whenReady(queue: DispatchQueue.main) {
            do { try Auth.auth().signOut() }
            catch { print("already logged out") }
            WitWork.shared.user = nil
            self.navigationService.showLaunch()
        }
    }
}

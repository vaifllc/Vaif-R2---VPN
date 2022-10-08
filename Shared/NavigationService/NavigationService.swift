//
//  NavigationService.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 9/26/22.
//

import Foundation
import GSMessages
import UIKit
import SwiftUI
import BugReport

// MARK: Country Service

protocol CountryService {
//    func makeCountriesViewController() -> CountriesViewController
//    func makeCountryViewController(country: CountryItemViewModel) -> CountryViewController
}

// MARK: Map Service

protocol MapService {
    //func makeMapViewController() -> MapViewController
}

// MARK: Profile Service

protocol ProfileService {
//    func makeProfilesViewController() -> ProfilesViewController
//    func makeCreateProfileViewController(for profile: Profile?) -> CreateProfileViewController?
//    func makeSelectionViewController(dataSet: SelectionDataSet, dataSelected: @escaping (Any) -> Void) -> SelectionViewController
}

// MARK: Settings Service

protocol SettingsService {
//    func makeSettingsViewController() -> SettingsViewController?
//    func makeSettingsAccountViewController() -> SettingsAccountViewController?
//    func makeExtensionsSettingsViewController() -> WidgetSettingsViewController
//    func makeLogSelectionViewController() -> LogSelectionViewController
//    func makeBatteryUsageViewController() -> BatteryUsageViewController
//    func makeLogsViewController(logSource: LogSource) -> LogsViewController
    func presentReportBug()
}

protocol SettingsServiceFactory {
    func makeSettingsService() -> SettingsService
}

// MARK: Protocol Service

protocol ProtocolService {
   // func makeVpnProtocolViewController(viewModel: VpnProtocolViewModel) -> VpnProtocolViewController
}

// MARK: Connection status Service

protocol ConnectionStatusServiceFactory {
    func makeConnectionStatusService() -> ConnectionStatusService
}

//extension DependencyContainer: ConnectionStatusServiceFactory {
//    func makeConnectionStatusService() -> ConnectionStatusService {
//        return makeNavigationService()
//    }
//}

protocol ConnectionStatusService {
    func presentStatusViewController()
}

typealias AlertService = CoreAlertService

protocol NavigationServiceFactory {
    func makeNavigationService() -> NavigationService
}

final class NavigationService: LoginErrorPresenter {
    func willPresentError(error: LoginError, from: UIViewController) -> Bool {
        return false
    }
    
    func willPresentError(error: SignupError, from: UIViewController) -> Bool {
        return false
    }
    
    func willPresentError(error: AvailabilityError, from: UIViewController) -> Bool {
        return false
    }
    
    func willPresentError(error: SetUsernameError, from: UIViewController) -> Bool {
        return false
    }
    
    func willPresentError(error: CreateAddressError, from: UIViewController) -> Bool {
        return false
    }
    
    func willPresentError(error: CreateAddressKeysError, from: UIViewController) -> Bool {
        return false
    }
    
    func willPresentError(error: StoreKitManagerErrors, from: UIViewController) -> Bool {
        return false
    }
    
    func willPresentError(error: ResponseError, from: UIViewController) -> Bool {
        return false
    }
    
    func willPresentError(error: Error, from: UIViewController) -> Bool {
        return false
    }
    
    
    typealias Factory = DependencyContainer
    private let factory: Factory
    
    // MARK: Storyboards
    private lazy var launchStoryboard = UIStoryboard(name: "LaunchScreen", bundle: nil)
    private lazy var mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
    private lazy var commonStoryboard = UIStoryboard(name: "Common", bundle: nil)
    private lazy var countriesStoryboard = UIStoryboard(name: "Countries", bundle: nil)
    private lazy var profilesStoryboard = UIStoryboard(name: "Profiles", bundle: nil)
    
    // MARK: Properties
    private lazy var propertiesManager: PropertiesManagerProtocol = factory.makePropertiesManager()
    lazy var windowService: WindowService = factory.makeWindowService()
//    private lazy var vpnKeychain: VpnKeychainProtocol = factory.makeVpnKeychain()
//    private lazy var vpnApiService: VpnApiService = factory.makeVpnApiService()
//    lazy var appStateManager: AppStateManager = factory.makeAppStateManager()
//    lazy var appSessionManager: AppSessionManager = factory.makeAppSessionManager()
//    lazy var authKeychain: AuthKeychainHandle = factory.makeAuthKeychainHandle()
    private lazy var alertService: CoreAlertService = factory.makeCoreAlertService()
//    private lazy var vpnManager: VpnManagerProtocol = factory.makeVpnManager()
    private lazy var uiAlertService: UIAlertService = factory.makeUIAlertService()
//    private lazy var vpnStateConfiguration: VpnStateConfiguration = factory.makeVpnStateConfiguration()
    private lazy var loginService: LoginService2 = {
        let loginService = factory.makeLoginService()
        loginService.delegate = self
        return loginService
    }()
    private lazy var networking: Networking = factory.makeNetworking()

    private lazy var bugReportCreator: BugReportCreator = factory.makeBugReportCreator()
    

    private let networkingDelegate: NetworkingDelegate // swiftlint:disable:this weak_delegate
    private let networking2: Networking
    private let doh: DoHVPN
    private var login: LoginAndSignupInterface?
    weak var delegate: LoginServiceDelegate?

    
    // MARK: Initializers
    init(_ factory: Factory) {
        self.factory = factory
        networkingDelegate = factory.makeNetworkingDelegate()
        networking2 = factory.makeNetworking()
        doh = factory.makeDoHVPN()
    }
    
    func launched() {
        let signupAvailability = SignupAvailability.available(parameters: SignupParameters(passwordRestrictions: SignupPasswordRestrictions.default, summaryScreenVariant: SummaryScreenVariant.noSummaryScreen))
        let login = LoginAndSignup(appName: "Proton VPN",
                                   clientApp: .vpn,
                                   doh: doh,
                                   apiServiceDelegate: networking,
                                  // forceUpgradeDelegate: networkingDelegate,
                                   humanVerificationVersion: networkingDelegate.version,
                                   minimumAccountType: AccountType.username,
                                   isCloseButtonAvailable: false)
        self.login = login

        var onboardingShowFirstConnection = true

        let variant = WelcomeScreenVariant.vpn(WelcomeScreenTexts(body: "Decentralized Virtual Privacy. An all new way to embrace online privacy."))
        let customization = LoginCustomizationOptions(username: nil, performBeforeFlow: nil, customErrorPresenter: self, helpDecorator: { input in
            let reportBugItem = HelpItem.custom(icon: UIImage(named: "ic-bug")!, title: "Report", behaviour: { [weak self] viewController in
                //self?.settingsService.presentReportBug()
            })
            var result = input
            if !result.isEmpty {
                result[0].append(reportBugItem)
            } else {
                result = [[reportBugItem]]
            }
            return result
        })
        let welcomeViewController = login.welcomeScreenForPresentingFlow(variant: variant, customization: customization) { [weak self] (result: LoginResult) -> Void in
            switch result {
            case .dismissed:
                print("Dismissing the Welcome screen without login or signup should not be possible")
            case .loggedIn:
                self?.delegate?.userDidLogIn()
            case .signedUp:
                self?.delegate?.userDidSignUp(onboardingShowFirstConnection: onboardingShowFirstConnection)
            }

            self?.login = nil
        }
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(welcomeViewController)
        //windowService.show(viewController: welcomeViewController)
    }

    func presentWelcome(initialError: String?) {
        loginService.showWelcome(initialError: initialError, withOverlayViewController: nil)
    }

    private func presentMainInterface() {
        setupTabs()
        showNewBrandModal()
    }
    
//    @objc private func sessionChanged(_ notification: Notification) {
//        guard appSessionManager.sessionStatus == .notEstablished else {
//            return
//        }
//        guard let reasonForSessionChange = notification.object as? String else {
//            presentWelcome(initialError: nil)
//            return
//        }
//
//        presentWelcome(initialError: reasonForSessionChange)
//    }
    
//    @objc private func refreshVpnManager(_ notification: Notification) {
//        vpnManager.refreshManagers()
//    }
    
    private func setupTabs() {
//        guard let tabBarController = tabBarController else { return }
//
//        tabBarController.viewModel = TabBarViewModel(navigationService: self, sessionManager: appSessionManager, appStateManager: appStateManager, vpnGateway: vpnGateway)
//
//        var tabViewControllers = [UIViewController]()
//
//        tabViewControllers.append(UINavigationController(rootViewController: makeCountriesViewController()))
//        tabViewControllers.append(UINavigationController(rootViewController: makeMapViewController()))
//
//        if let protonQCViewController = mainStoryboard.instantiateViewController(withIdentifier: "ProtonQCViewController") as? ProtonQCViewController {
//            tabViewControllers.append(protonQCViewController)
//        }
//
//        tabViewControllers.append(UINavigationController(rootViewController: makeProfilesViewController()))
//
//        if let settingsViewController = makeSettingsViewController() {
//            tabViewControllers.append(UINavigationController(rootViewController: settingsViewController))
//        }
//
//        tabBarController.setViewControllers(tabViewControllers, animated: false)
//        tabBarController.setupView()
//
//        windowService.show(viewController: tabBarController)
    }

    private func showNewBrandModal() {
        guard !propertiesManager.newBrandModalShown else {
            return
        }
        alertService.push(alert: NewBrandAlert())
        propertiesManager.newBrandModalShown = true
    }
    
    func makeLaunchViewController() -> LaunchViewController? {
        if let launchViewController = launchStoryboard.instantiateViewController(withIdentifier: "LaunchViewController") as? LaunchViewController {
            launchViewController.mode = .delayed
            return launchViewController
        }
        return nil
    }
    
//    private func makeTabBarController() -> TabBarController? {
//        guard let tabBarController = mainStoryboard.instantiateViewController(withIdentifier: "TabBarController") as? TabBarController else { return nil }
//        tabBarController.viewModel = TabBarViewModel(navigationService: self,
//                                                     sessionManager: appSessionManager,
//                                                     appStateManager: appStateManager,
//                                                     vpnGateway: vpnGateway)
//
//        return tabBarController
//    }
}

//extension NavigationService: CountryService {
//    func makeCountriesViewController() -> CountriesViewController {
//        let countriesViewController = countriesStoryboard.instantiateViewController(withIdentifier: String(describing: CountriesViewController.self)) as! CountriesViewController
//        countriesViewController.viewModel = CountriesViewModel(factory: factory, vpnGateway: vpnGateway, countryService: self)
//        countriesViewController.connectionBarViewController = makeConnectionBarViewController()
//
//        return countriesViewController
//    }
//
//    func makeCountryViewController(country: CountryItemViewModel) -> CountryViewController {
//        let countryViewController = countriesStoryboard.instantiateViewController(withIdentifier: String(describing: CountryViewController.self)) as! CountryViewController
//        countryViewController.viewModel = country
//        countryViewController.connectionBarViewController = makeConnectionBarViewController()
//        return countryViewController
//    }
//}

//extension NavigationService: MapService {
//    func makeMapViewController() -> MapViewController {
//        let mapViewController = mainStoryboard.instantiateViewController(withIdentifier: String(describing: MapViewController.self)) as! MapViewController
//        mapViewController.viewModel = MapViewModel(appStateManager: appStateManager, alertService: alertService, serverStorage: ServerStorageConcrete(), vpnGateway: vpnGateway, vpnKeychain: vpnKeychain, propertiesManager: propertiesManager, connectionStatusService: self)
//        mapViewController.connectionBarViewController = makeConnectionBarViewController()
//        return mapViewController
//    }
//}

//extension NavigationService: ProfileService {
//    func makeProfilesViewController() -> ProfilesViewController {
//        let profilesViewController = profilesStoryboard.instantiateViewController(withIdentifier: String(describing: ProfilesViewController.self)) as! ProfilesViewController
//        profilesViewController.viewModel = ProfilesViewModel(vpnGateway: vpnGateway, factory: self, alertService: alertService, propertiesManager: propertiesManager, connectionStatusService: self, netShieldPropertyProvider: factory.makeNetShieldPropertyProvider(), natTypePropertyProvider: factory.makeNATTypePropertyProvider(), safeModePropertyProvider: factory.makeSafeModePropertyProvider(), planService: planService, profileManager: profileManager)
//        profilesViewController.connectionBarViewController = makeConnectionBarViewController()
//        return profilesViewController
//    }
//
//    func makeCreateProfileViewController(for profile: Profile?) -> CreateProfileViewController? {
//        guard let username = authKeychain.fetch()?.username else {
//            return nil
//        }
//
//        guard let createProfileViewController = profilesStoryboard.instantiateViewController(withIdentifier: String(describing: CreateProfileViewController.self)) as? CreateProfileViewController else {
//            return nil
//        }
//
//        let serverManager = ServerManagerImplementation.instance(forTier: CoreAppConstants.VpnTiers.visionary,
//                                                                 serverStorage: ServerStorageConcrete())
//
//        createProfileViewController.viewModel = CreateOrEditProfileViewModel(username: username,
//                                                                             for: profile,
//                                                                             profileService: self,
//                                                                             protocolSelectionService: self,
//                                                                             alertService: alertService,
//                                                                             vpnKeychain: vpnKeychain,
//                                                                             serverManager: serverManager,
//                                                                             appStateManager: appStateManager,
//                                                                             vpnGateway: vpnGateway!,
//                                                                             profileManager: profileManager,
//                                                                             propertiesManager: propertiesManager)
//        return createProfileViewController
//    }
//
//    func makeSelectionViewController(dataSet: SelectionDataSet, dataSelected: @escaping (Any) -> Void) -> SelectionViewController {
//        let selectionViewController = profilesStoryboard.instantiateViewController(withIdentifier: String(describing: SelectionViewController.self)) as! SelectionViewController
//        selectionViewController.dataSet = dataSet
//        selectionViewController.dataSelected = dataSelected
//        return selectionViewController
//    }
//}

//extension NavigationService: SettingsService {
//
//    func makeSettingsViewController() -> SettingsViewController? {
//        if let settingsViewController = mainStoryboard.instantiateViewController(withIdentifier: String(describing: SettingsViewController.self)) as? SettingsViewController {
//            settingsViewController.viewModel = SettingsViewModel(factory: factory, protocolService: self)
//            settingsViewController.connectionBarViewController = makeConnectionBarViewController()
//            return settingsViewController
//        }
//
//        return nil
//    }
//
//    func makeSettingsAccountViewController() -> SettingsAccountViewController? {
//        guard let connectionBar = makeConnectionBarViewController() else { return nil }
//        return SettingsAccountViewController(viewModel: SettingsAccountViewModel(factory: factory), connectionBar: connectionBar)
//    }
//
//    func makeExtensionsSettingsViewController() -> WidgetSettingsViewController {
//        return WidgetSettingsViewController(viewModel: WidgetSettingsViewModel())
//    }
//
//    func makeLogSelectionViewController() -> LogSelectionViewController {
//
//        return LogSelectionViewController(viewModel: LogSelectionViewModel(), settingsService: self)
//    }
//
//    func makeBatteryUsageViewController() -> BatteryUsageViewController {
//        return BatteryUsageViewController()
//    }
//
//    func makeLogsViewController(logSource: LogSource) -> LogsViewController {
//        return LogsViewController(viewModel: LogsViewModel(title: logSource.title, logContent: factory.makeLogContentProvider().getLogData(for: logSource)))
//    }
//
//    func presentReportBug() {
//        if #available(iOS 14.0.0, *), !ProcessInfo.processInfo.arguments.contains("UITests") { // Switch to old report bug because new flow is tested separately in sample app
//            let manager = factory.makeDynamicBugReportManager()
//            if let viewController = bugReportCreator.createBugReportViewController(delegate: manager, colors: Colors()) {
//                manager.closeBugReportHandler = {
//                    self.windowService.dismissModal { }
//                }
//                windowService.present(modal: viewController)
//                return
//            }
//        }
//
//        let viewController = ReportBugViewController(vpnManager: vpnManager)
//        viewController.viewModel = ReportBugViewModel(os: "iOS",
//                                                      osVersion: UIDevice.current.systemVersion,
//                                                      propertiesManager: propertiesManager,
//                                                      reportsApiService: ReportsApiService(networking: networking,
//                                                                                           authKeychain: authKeychain),
//                                                      alertService: alertService,
//                                                      vpnKeychain: vpnKeychain,
//                                                      logContentProvider: factory.makeLogContentProvider(),
//                                                      authKeychain: authKeychain)
//        viewController.appLogFileUrl = factory.makeLogFileManager().getFileUrl(named: AppConstants.Filenames.appLogFilename)
//        let navigationController = UINavigationController(rootViewController: viewController)
//        windowService.present(modal: navigationController)
//    }
//}

//extension NavigationService: ProtocolService {
//    func makeVpnProtocolViewController(viewModel: VpnProtocolViewModel) -> VpnProtocolViewController {
//        return VpnProtocolViewController(viewModel: viewModel)
//    }
//}

//extension NavigationService: ConnectionStatusService {
//    func makeConnectionBarViewController() -> ConnectionBarViewController? {
//
//        if let connectionBarViewController =
//            self.commonStoryboard.instantiateViewController(withIdentifier:
//                String(describing: ConnectionBarViewController.self)) as? ConnectionBarViewController {
//
//            connectionBarViewController.viewModel = ConnectionBarViewModel(appStateManager: appStateManager)
//            connectionBarViewController.connectionStatusService = self
//            return connectionBarViewController
//        }
//
//        return nil
//    }
//
//    func makeStatusViewController() -> StatusViewController? {
//        if let statusViewController =
//            self.commonStoryboard.instantiateViewController(withIdentifier:
//                String(describing: StatusViewController.self)) as? StatusViewController {
//            statusViewController.viewModel = StatusViewModel(factory: factory)
//            return statusViewController
//        }
//        return nil
//    }
//
//    func presentStatusViewController() {
//        guard let viewController = makeStatusViewController() else {
//            return
//        }
//        self.windowService.addToStack(viewController, checkForDuplicates: true)
//    }
//}

// MARK: Login delegate

extension NavigationService: LoginServiceDelegate {
    func userDidLogIn() {
        presentMainInterface()
    }

    func userDidSignUp(onboardingShowFirstConnection: Bool) {
        propertiesManager.newBrandModalShown = true
        //onboardingService.showOnboarding(showFirstConnection: onboardingShowFirstConnection)
    }
}

// MARK: Onboarding delegate

//extension NavigationService: OnboardingServiceDelegate {
//    func onboardingServiceDidFinish() {
//        presentMainInterface()
//    }
//}

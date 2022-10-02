//
//  DependencyContainer.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 9/27/22.
//

import Foundation
import KeychainAccess
import BugReport
import Search
import Review
import NetworkExtension
import TrustKit

// FUTURETODO: clean up objects that are possible to re-create if memory warning is received

// FUTURETODO: clean up objects that are possible to re-create if memory warning is received

final class DependencyContainer {
    
    private let appGroup = AppConstants.AppGroups.main
    
    // Singletons
    private lazy var navigationService = NavigationService(self)

//    private lazy var vpnGateway: VpnGateway = VpnGateway(vpnApiService: makeVpnApiService(),
//                                                         appStateManager: makeAppStateManager(),
//                                                         alertService: makeCoreAlertService(),
//                                                         vpnKeychain: makeVpnKeychain(),
//                                                         authKeychain: makeAuthKeychainHandle(),
//                                                         siriHelper: SiriHelper(),
//                                                         netShieldPropertyProvider: makeNetShieldPropertyProvider(),
//                                                         natTypePropertyProvider: makeNATTypePropertyProvider(),
//                                                         safeModePropertyProvider: makeSafeModePropertyProvider(),
//                                                         propertiesManager: makePropertiesManager(),
//                                                         profileManager: makeProfileManager(),
//                                                         availabilityCheckerResolverFactory: self,
//                                                         serverStorage: makeServerStorage())
//    private lazy var vpnManager: VpnManagerProtocol = VpnManager(ikeFactory: ikeFactory,
//                                                                 openVpnFactory: openVpnFactory,
//                                                                 wireguardProtocolFactory: wireguardFactory,
//                                                                 appGroup: appGroup,
//                                                                 vpnAuthentication: makeVpnAuthentication(),
//                                                                 vpnKeychain: vpnKeychain,
//                                                                 propertiesManager: makePropertiesManager(),
//                                                                 vpnStateConfiguration: makeVpnStateConfiguration(),
//                                                                 alertService: iosAlertService,
//                                                                 vpnCredentialsConfiguratorFactory: IOSVpnCredentialsConfiguratorFactory(propertiesManager: makePropertiesManager()),
//                                                                 localAgentConnectionFactory: LocalAgentConnectionFactoryImplementation(),
//                                                                 natTypePropertyProvider: makeNATTypePropertyProvider(),
//                                                                 netShieldPropertyProvider: makeNetShieldPropertyProvider(),
//                                                                 safeModePropertyProvider: makeSafeModePropertyProvider())
    //private lazy var wireguardFactory = WireguardProtocolFactory(bundleId: AppConstants.NetworkExtensions.wireguard, appGroup: appGroup, propertiesManager: makePropertiesManager(), vpnManagerFactory: self)
    //private lazy var ikeFactory = IkeProtocolFactory(factory: self)
    //private lazy var openVpnFactory = OpenVpnProtocolFactory(bundleId: AppConstants.NetworkExtensions.openVpn, appGroup: appGroup, propertiesManager: makePropertiesManager(), vpnManagerFactory: self)
    //private lazy var vpnKeychain: VpnKeychainProtocol = VpnKeychain()
    private lazy var windowService: WindowService = WindowServiceImplementation(window: UIWindow(frame: UIScreen.main.bounds))
    private lazy var timerFactory: TimerFactory = TimerFactoryImplementation()
//    private lazy var appStateManager: AppStateManager = AppStateManagerImplementation(
//                                                                        vpnApiService: makeVpnApiService(),
//                                                                        vpnManager: makeVpnManager(),
//                                                                        networking: makeNetworking(),
//                                                                        alertService: makeCoreAlertService(),
//                                                                        timerFactory: timerFactory,
//                                                                        propertiesManager: makePropertiesManager(),
//                                                                        vpnKeychain: makeVpnKeychain(),
//                                                                        configurationPreparer: makeVpnManagerConfigurationPreparer(),
//                                                                        vpnAuthentication: makeVpnAuthentication(),
//                                                                        doh: makeDoHVPN(),
//                                                                        serverStorage: makeServerStorage(),
//                                                                        natTypePropertyProvider: makeNATTypePropertyProvider(),
//                                                                        netShieldPropertyProvider: makeNetShieldPropertyProvider(),
//                                                                        safeModePropertyProvider: makeSafeModePropertyProvider())
    //private lazy var appSessionManager: AppSessionManagerImplementation = AppSessionManagerImplementation(factory: self)
    private lazy var uiAlertService: UIAlertService = IosUiAlertService(windowService: makeWindowService()/*, planService: makePlanService()*/)
    private lazy var iosAlertService: CoreAlertService = IosAlertService(self)
    
//    private lazy var maintenanceManager: MaintenanceManagerProtocol = MaintenanceManager(factory: self)
//    private lazy var maintenanceManagerHelper: MaintenanceManagerHelper = MaintenanceManagerHelper(factory: self)
    
    // Refreshes app data at predefined time intervals
//    private lazy var refreshTimer = AppSessionRefreshTimer(factory: self,
//                                                           timerFactory: timerFactory,
//                                                           refreshIntervals: (AppConstants.Time.fullServerRefresh,
//                                                                              AppConstants.Time.serverLoadsRefresh,
//                                                                              AppConstants.Time.userAccountRefresh))
    // Refreshes announements from API
    //private lazy var announcementRefresher = AnnouncementRefresherImplementation(factory: self)
    
    // Instance of DynamicBugReportManager is persisted because it has a timer that refreshes config from time to time.
//    private lazy var dynamicBugReportManager = DynamicBugReportManager(
//        api: makeReportsApiService(),
//        storage: DynamicBugReportStorageUserDefaults(userDefaults: Storage()),
//        alertService: makeCoreAlertService(),
//        propertiesManager: makePropertiesManager(),
//        updateChecker: makeUpdateChecker(),
//        vpnKeychain: makeVpnKeychain(),
//        logContentProvider: makeLogContentProvider()
//    )

    private lazy var authKeychain: AuthKeychainHandle = AuthKeychain()

//    private lazy var vpnAuthentication: VpnAuthentication = {
//        let appIdentifierPrefix = Bundle.main.infoDictionary!["AppIdentifierPrefix"] as! String
//        let vpnAuthKeychain = VpnAuthenticationKeychain(accessGroup: "\(appIdentifierPrefix)prt.ProtonVPN", storage: storage)
//        return VpnAuthenticationRemoteClient(sessionService: makeSessionService(),
//                                             authenticationStorage: vpnAuthKeychain,
//                                             safeModePropertyProvider: makeSafeModePropertyProvider())
//    }()
    
    #if TLS_PIN_DISABLE
    private lazy var trustKitHelper: TrustKitHelper? = nil
    #else
    private lazy var trustKitHelper: TrustKitHelper? = TrustKitHelper()
    #endif

    private lazy var storage = Storage()
    private lazy var propertiesManager = PropertiesManager(storage: storage)
    private lazy var networkingDelegate: NetworkingDelegate = iOSNetworkingDelegate(alertingService: makeCoreAlertService()) // swiftlint:disable:this weak_delegate
    private lazy var networking = CoreNetworking(delegate: networkingDelegate, appInfo: makeAppInfo(), doh: makeDoHVPN(), authKeychain: makeAuthKeychainHandle())
    //private lazy var planService = CorePlanService(networking: networking, alertService: makeCoreAlertService(), storage: storage, authKeychain: makeAuthKeychainHandle())
    private lazy var appInfo = makeAppInfo()
    private lazy var doh: DoHVPN = {
        #if !RELEASE
        let atlasSecret: String? = ObfuscatedConstants.atlasSecret
        #else
        let atlasSecret: String? = nil
        #endif
        let doh = DoHVPN(apiHost: ObfuscatedConstants.apiHost,
                         verifyHost: ObfuscatedConstants.humanVerificationV3Host,
                         alternativeRouting: propertiesManager.alternativeRouting,
                         customHost: propertiesManager.apiEndpoint,
                         atlasSecret: atlasSecret,
                         appState: .disconnected // AppState is not known yet, because DoH is initialized before AppStateManager
        )
        propertiesManager.onAlternativeRoutingChange = { alternativeRouting in
            doh.alternativeRouting = alternativeRouting
        }
        return doh
    }()
    //lazy var profileManager = ProfileManager(serverStorage: makeServerStorage(), propertiesManager: makePropertiesManager(), profileStorage: ProfileStorage(authKeychain: makeAuthKeychainHandle()))
    //private lazy var searchStorage = SearchModuleStorage(storage: storage)
   // private lazy var review = Review(configuration: Configuration(settings: propertiesManager.ratingSettings), plan: (try? vpnKeychain.fetchCached().accountPlan.description), logger: { message in log.debug("\(message)", category: .review) })
}

// MARK: NavigationServiceFactory
extension DependencyContainer: NavigationServiceFactory {
    func makeNavigationService() -> NavigationService {
        return navigationService
    }
}

// MARK: SettingsServiceFactory
extension DependencyContainer: SettingsServiceFactory {
    func makeSettingsService() -> SettingsService {
        return navigationService
    }
}

// MARK: VpnManagerFactory
//extension DependencyContainer: VpnManagerFactory {
//    func makeVpnManager() -> VpnManagerProtocol {
//        return vpnManager
//    }
//}

// MARK: VpnManagerConfigurationPreparer
//extension DependencyContainer: VpnManagerConfigurationPreparerFactory {
//    func makeVpnManagerConfigurationPreparer() -> VpnManagerConfigurationPreparer {
//        return VpnManagerConfigurationPreparer(vpnKeychain: makeVpnKeychain(),
//                                               alertService: makeCoreAlertService(),
//                                               propertiesManager: makePropertiesManager()
//        )
//    }
//}

// MARK: VpnKeychainFactory
//extension DependencyContainer: VpnKeychainFactory {
//    func makeVpnKeychain() -> VpnKeychainProtocol {
//        return vpnKeychain
//    }
//}

// MARK: PropertiesManagerFactory
extension DependencyContainer: PropertiesManagerFactory {
    func makePropertiesManager() -> PropertiesManagerProtocol {
        return propertiesManager
    }
}

// MARK: WindowServiceFactory
extension DependencyContainer: WindowServiceFactory {
    func makeWindowService() -> WindowService {
        return windowService
    }
}

// MARK: VpnApiServiceFactory
//extension DependencyContainer: VpnApiServiceFactory {
//    func makeVpnApiService() -> VpnApiService {
//        return VpnApiService(networking: makeNetworking())
//    }
//}

// MARK: CoreAlertServiceFactory
extension DependencyContainer: CoreAlertServiceFactory {
    func makeCoreAlertService() -> CoreAlertService {
        return iosAlertService
    }
}

// MARK: AppStateManagerFactory
//extension DependencyContainer: AppStateManagerFactory {
//    func makeAppStateManager() -> AppStateManager {
//        return appStateManager
//    }
//}

// MARK: AppSessionManagerFactory
//extension DependencyContainer: AppSessionManagerFactory {
//    func makeAppSessionManager() -> AppSessionManager {
//        return appSessionManager
//    }
//}

// MARK: ServerStorageFactory
//extension DependencyContainer: ServerStorageFactory {
//    func makeServerStorage() -> ServerStorage {
//        return ServerStorageConcrete()
//    }
//}

// MARK: VpnGatewayFactory
//extension DependencyContainer: VpnGatewayFactory {
//    func makeVpnGateway() -> VpnGatewayProtocol {
//        return vpnGateway
//    }
//}

// MARK: ReportBugViewModelFactory
extension DependencyContainer: ReportBugViewModelFactory {
    func makeReportBugViewModel() -> ReportBugViewModel {
        return ReportBugViewModel(os: "iOS",
                                  osVersion: ProcessInfo.processInfo.operatingSystemVersionString,
                                  propertiesManager: makePropertiesManager(),
                                  reportsApiService: makeReportsApiService(),
                                  alertService: makeCoreAlertService(),
                                 // vpnKeychain: makeVpnKeychain(),
                                  logContentProvider: makeLogContentProvider(),
                                  authKeychain: makeAuthKeychainHandle())
    }
}

// MARK: ReportsApiServiceFactory
extension DependencyContainer: ReportsApiServiceFactory {
    func makeReportsApiService() -> ReportsApiService {
        return ReportsApiService(networking: makeNetworking(), authKeychain: makeAuthKeychainHandle())
    }
}

// MARK: UIAlertServiceFactory
extension DependencyContainer: UIAlertServiceFactory {
    func makeUIAlertService() -> UIAlertService {
        return uiAlertService
    }
}

// MARK: TrustKitHelperFactory
extension DependencyContainer: TrustKitHelperFactory {
    func makeTrustKitHelper() -> TrustKitHelper? {
        return trustKitHelper
    }
}

// MARK: AppSessionRefreshTimerFactory
//extension DependencyContainer: AppSessionRefreshTimerFactory {
//    func makeAppSessionRefreshTimer() -> AppSessionRefreshTimer {
//        return refreshTimer
//    }
//}

// MARK: - AppSessionRefresherFactory
//extension DependencyContainer: AppSessionRefresherFactory {
//    func makeAppSessionRefresher() -> AppSessionRefresher {
//        return appSessionManager
//    }
//}
        
// MARK: - MaintenanceManagerFactory
//extension DependencyContainer: MaintenanceManagerFactory {
//    func makeMaintenanceManager() -> MaintenanceManagerProtocol {
//        return maintenanceManager
//    }
//}

// MARK: - MaintenanceManagerHelperFactory
//extension DependencyContainer: MaintenanceManagerHelperFactory {
//    func makeMaintenanceManagerHelper() -> MaintenanceManagerHelper {
//        return maintenanceManagerHelper
//    }
//}

// MARK: - ProfileManagerFactory
//extension DependencyContainer: ProfileManagerFactory {
//    func makeProfileManager() -> ProfileManager {
//        return profileManager
//    }
//}

// MARK: - AnnouncementRefresherFactory
//extension DependencyContainer: AnnouncementRefresherFactory {
//    func makeAnnouncementRefresher() -> AnnouncementRefresher {
//        return announcementRefresher
//    }
//}

// MARK: - AnnouncementStorageFactory
//extension DependencyContainer: AnnouncementStorageFactory {
//    func makeAnnouncementStorage() -> AnnouncementStorage {
//        return AnnouncementStorageUserDefaults(userDefaults: Storage.userDefaults(), keyNameProvider: nil)
//    }
//}

// MARK: - AnnouncementManagerFactory
//extension DependencyContainer: AnnouncementManagerFactory {
//    func makeAnnouncementManager() -> AnnouncementManager {
//        return AnnouncementManagerImplementation(factory: self)
//    }
//}

// MARK: - CoreApiServiceFactory
//extension DependencyContainer: CoreApiServiceFactory {
//    func makeCoreApiService() -> CoreApiService {
//        return CoreApiServiceImplementation(networking: makeNetworking())
//    }
//}

// MARK: - AnnouncementsViewModelFactory
//extension DependencyContainer: AnnouncementsViewModelFactory {
//    func makeAnnouncementsViewModel() -> AnnouncementsViewModel {
//        return AnnouncementsViewModel(factory: self)
//    }
//}

// MARK: - SafariServiceFactory
extension DependencyContainer: SafariServiceFactory {
    func makeSafariService() -> SafariServiceProtocol {
        return SafariService()
    }
}

// MARK: - UserTierProviderFactory
//extension DependencyContainer: UserTierProviderFactory {
//    func makeUserTierProvider() -> UserTierProvider {
//        return UserTierProviderImplementation(self)
//    }
//}

// MARK: - NetShieldPropertyProviderFactory
//extension DependencyContainer: NetShieldPropertyProviderFactory {
//    func makeNetShieldPropertyProvider() -> NetShieldPropertyProvider {
//        return NetShieldPropertyProviderImplementation(self, storage: storage)
//    }
//}

// MARK: TroubleshootViewModelFactory
extension DependencyContainer: TroubleshootViewModelFactory {
    func makeTroubleshootViewModel() -> TroubleshootViewModel {
        return TroubleshootViewModel(propertiesManager: makePropertiesManager())
    }
}

// MARK: VpnAuthenticationManagerFactory
//extension DependencyContainer: VpnAuthenticationFactory {
//    func makeVpnAuthentication() -> VpnAuthentication {
//        return vpnAuthentication
//    }
//}

// MARK: VpnStateConfigurationFactory
//extension DependencyContainer: VpnStateConfigurationFactory {
//    func makeVpnStateConfiguration() -> VpnStateConfiguration {
//        return VpnStateConfigurationManager(ikeProtocolFactory: ikeFactory, openVpnProtocolFactory: openVpnFactory, wireguardProtocolFactory: wireguardFactory, propertiesManager: makePropertiesManager(), appGroup: appGroup)
//    }
//}

// MARK: LoginServiceFactory
extension DependencyContainer: LoginServiceFactory {
    func makeLoginService() -> LoginService2 {
        return CoreLoginService(factory: self)
    }
}

// MARK: NetworkingFactory
extension DependencyContainer: NetworkingFactory {
    func makeNetworking() -> Networking {
        return networking
    }
}

// MARK: NetworkingDelegateFactory
extension DependencyContainer: NetworkingDelegateFactory {
    func makeNetworkingDelegate() -> NetworkingDelegate {
        return networkingDelegate
    }
}

// MARK: PlanServiceFactory
//extension DependencyContainer: PlanServiceFactory {
//    func makePlanService() -> PlanService {
//        return planService
//    }
//}

// MARK: LogFileManagerFactory
//extension DependencyContainer: LogFileManagerFactory {
//    func makeLogFileManager() -> LogFileManager {
//        return LogFileManagerImplementation()
//    }
//}

// MARK: AppInfoFactory
extension DependencyContainer: AppInfoFactory {
    func makeAppInfo(context: AppContext) -> AppInfo {
        return AppInfoImplementation(context: context)
    }
}

// MARK: DoHVPNFactory
extension DependencyContainer: DoHVPNFactory {
    func makeDoHVPN() -> DoHVPN {
        return doh
    }
}

// MARK: OnboardingServiceFactory
//extension DependencyContainer: OnboardingServiceFactory {
//    func makeOnboardingService() -> OnboardingService {
//        return OnboardingModuleService(factory: self)
//    }
//}

// MARK: BugReportCreatorFactory
extension DependencyContainer: BugReportCreatorFactory {
    func makeBugReportCreator() -> BugReportCreator {
        return iOSBugReportCreator()
    }
}

// MARK: DynamicBugReportManagerFactory
//extension DependencyContainer: DynamicBugReportManagerFactory {
//    func makeDynamicBugReportManager() -> DynamicBugReportManager {
//        return dynamicBugReportManager
//    }
//}

// MARK: NATTypePropertyProviderFactory
//extension DependencyContainer: NATTypePropertyProviderFactory {
//    func makeNATTypePropertyProvider() -> NATTypePropertyProvider {
//        return NATTypePropertyProviderImplementation(self, storage: storage)
//    }
//}

// MARK: SafeModePropertyProviderFactory
//extension DependencyContainer: SafeModePropertyProviderFactory {
//    func makeSafeModePropertyProvider() -> SafeModePropertyProvider {
//        return SafeModePropertyProviderImplementation(self, storage: storage)
//    }
//}

// MARK: SearchStorageFactory
//extension DependencyContainer: SearchStorageFactory {
//    func makeSearchStorage() -> SearchStorage {
//        return searchStorage
//    }
//}

// MARK: ReviewFactory
//extension DependencyContainer: ReviewFactory {
//    func makeReview() -> Review {
//        return review
//    }
//}

// MARK: PaymentsApiServiceFactory
//extension DependencyContainer: PaymentsApiServiceFactory {
//    func makePaymentsApiService() -> PaymentsApiService {
//        return PaymentsApiServiceImplementation(networking: makeNetworking(), vpnKeychain: makeVpnKeychain(), vpnApiService: makeVpnApiService())
//    }
//}

// MARK: CouponViewModelFactory
//extension DependencyContainer: CouponViewModelFactory {
//    func makeCouponViewModel() -> CouponViewModel {
//        return CouponViewModel(paymentsApiService: makePaymentsApiService(), appSessionRefresher: appSessionManager)
//    }
//}

// MARK: LogContentProviderFactory
extension DependencyContainer: LogContentProviderFactory {
    func makeLogContentProvider() -> LogContentProvider {
        return IOSLogContentProvider(appLogsFolder: LogFileManagerImplementation().getFileUrl(named: AppConstants.Filenames.appLogFilename).deletingLastPathComponent(),
                                     appGroup: AppConstants.AppGroups.main)
    }
}

// MARK: SessionServiceFactory
//extension DependencyContainer: SessionServiceFactory {
//    func makeSessionService() -> SessionService {
//        return SessionServiceImplementation(factory: self)
//    }
//}

// MARK: NEVPNManagerWrapperFactory
//extension DependencyContainer: NEVPNManagerWrapperFactory {
//    func makeNEVPNManagerWrapper() -> NEVPNManagerWrapper {
//        NEVPNManager.shared()
//    }
//}

// MARK: NETunnelProviderManagerWrapperFactory
//extension DependencyContainer: NETunnelProviderManagerWrapperFactory {
//    func makeNewManager() -> NETunnelProviderManagerWrapper {
//        NETunnelProviderManager()
//    }
//
//    func loadManagersFromPreferences(completionHandler: @escaping ([NETunnelProviderManagerWrapper]?, Error?) -> Void) {
//        NETunnelProviderManager.loadAllFromPreferences { managers, error in
//            completionHandler(managers, error)
//        }
//    }
//}

// MARK: AvailabilityCheckerResolverFactory
//extension DependencyContainer: AvailabilityCheckerResolverFactory {
//    func makeAvailabilityCheckerResolver(openVpnConfig: OpenVpnConfig, wireguardConfig: WireguardConfig) -> AvailabilityCheckerResolver {
//        AvailabilityCheckerResolverImplementation(openVpnConfig: openVpnConfig, wireguardConfig: wireguardConfig)
//    }
//}

// MARK: AuthKeychainHandleFactory
extension DependencyContainer: AuthKeychainHandleFactory {
    func makeAuthKeychainHandle() -> AuthKeychainHandle {
        return authKeychain
    }
}


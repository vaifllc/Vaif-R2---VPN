//
//  IosAlertService.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 9/27/22.
//

import UIKit
import Foundation
import Modals
import Modals_iOS
import UIKit
import Logging



class IosAlertService {
        
    typealias Factory = UIAlertServiceFactory & WindowServiceFactory & SettingsServiceFactory & TroubleshootCoordinatorFactory
    private let factory: Factory
    
    private lazy var uiAlertService: UIAlertService = factory.makeUIAlertService()
   // private lazy var appSessionManager: AppSessionManager = factory.makeAppSessionManager()
    private lazy var windowService: WindowService = factory.makeWindowService()
    private lazy var settingsService: SettingsService = factory.makeSettingsService()
   // private lazy var safariService: SafariServiceProtocol = factory.makeSafariService()

   // private lazy var planService: PlanService = factory.makePlanService()
    private lazy var modalsFactory: ModalsFactory = ModalsFactory(colors: UpsellColors())
    
    init(_ factory: Factory) {
        self.factory = factory
    }
}

extension IosAlertService: CoreAlertService {

    func push(alert: SystemAlert) {
        executeOnUIThread {
            self.pushOnUIThread(alert: alert)
        }
    }

    // swiftlint:disable cyclomatic_complexity function_body_length
    func pushOnUIThread(alert: SystemAlert) {
       // log.debug("Alert shown: \(String(describing: type(of: alert)))", category: .ui)

        switch alert {
        case is AccountDeletionErrorAlert:
            showDefaultSystemAlert(alert)
            
        case is AccountDeletionWarningAlert:
            showDefaultSystemAlert(alert)
            
        case let appUpdateRequiredAlert as AppUpdateRequiredAlert:
            show(appUpdateRequiredAlert)
            
        case let cannotAccessVpnCredentialsAlert as CannotAccessVpnCredentialsAlert:
            show(cannotAccessVpnCredentialsAlert)
            
        case is ExistingConnectionAlert:
            showDefaultSystemAlert(alert)
            
        case is FirstTimeConnectingAlert:
            break // do nothing
            
        case is P2pBlockedAlert:
            showDefaultSystemAlert(alert)
            
        case is P2pForwardedAlert:
            showDefaultSystemAlert(alert)
            
        case let refreshTokenExpiredAlert as RefreshTokenExpiredAlert:
            show(refreshTokenExpiredAlert)
            
        case is UpgradeUnavailableAlert:
            showDefaultSystemAlert(alert)
            
        case is DelinquentUserAlert:
            showDefaultSystemAlert(alert)
            
        case is VpnStuckAlert:
            showDefaultSystemAlert(alert)
            
        case is VpnNetworkUnreachableAlert:
            showNotificationStyleAlert(message: alert.title ?? alert.message ?? "")
            
        case is MaintenanceAlert:
            showDefaultSystemAlert(alert)
            
        case is SecureCoreToggleDisconnectAlert:
            showDefaultSystemAlert(alert)
            
        case is ChangeProtocolDisconnectAlert:
            showDefaultSystemAlert(alert)
            
        case is LogoutWarningAlert:
            showDefaultSystemAlert(alert)

        case is BugReportSentAlert:
            showDefaultSystemAlert(alert)
            
        case is UnknownErrortAlert:
            showDefaultSystemAlert(alert)
            
        case let reportBugAlert as ReportBugAlert:
            show(reportBugAlert)

        case is MITMAlert:
            showDefaultSystemAlert(alert)
            
        case is UnreachableNetworkAlert:
            showDefaultSystemAlert(alert)
            
        case let connectionTroubleshootingAlert as ConnectionTroubleshootingAlert:
            show(connectionTroubleshootingAlert)
            
        case is ReconnectOnNetshieldChangeAlert:
            showDefaultSystemAlert(alert)

        case let vpnServerOnMaintenanceAlert as VpnServerOnMaintenanceAlert:
            show(vpnServerOnMaintenanceAlert)

        case is VPNAuthCertificateRefreshErrorAlert:
            showDefaultSystemAlert(alert)
            
        case let alert as UserAccountUpdateAlert:
            displayUserUpdateAlert(alert: alert)

        case is ReconnectOnSmartProtocolChangeAlert:
            showDefaultSystemAlert(alert)
            
        case is ReconnectOnActionAlert:
            showDefaultSystemAlert(alert)

        case is VpnServerErrorAlert:
            showDefaultSystemAlert(alert)

        case is VpnServerSubscriptionErrorAlert:
            showDefaultSystemAlert(alert)
            
        case is AllowLANConnectionsAlert:
            showDefaultSystemAlert(alert)
            
        case is TurnOnKillSwitchAlert:
            showDefaultSystemAlert(alert)
            
        case is ReconnectOnSettingsChangeAlert:
            showDefaultSystemAlert(alert)

        case let announcementOfferAlert as AnnouncmentOfferAlert: break
            //show(announcementOfferAlert)
            
        case let subuserAlert as SubuserWithoutConnectionsAlert: break
            //show(subuserAlert)
            
        case is TooManyCertificateRequestsAlert:
            showDefaultSystemAlert(alert)

        case let discourageAlert as DiscourageSecureCoreAlert:
            show(discourageAlert)

        case let newBrandAlert as NewBrandAlert:
            show(newBrandAlert)
            
        case is SafeModeUpsellAlert:
            show(upsellType: .safeMode)

        case is NetShieldUpsellAlert:
            show(upsellType: .netShield)

        case is SecureCoreUpsellAlert:
            show(upsellType: .secureCore)

        case is ModerateNATUpsellAlert:
            show(upsellType: .moderateNAT)

        case is AllCountriesUpsellAlert:
            break
//            let plus = AccountPlan.plus
//            let allCountriesUpsell = UpsellType.allCountries(numberOfDevices: plus.devicesCount, numberOfServers: plus.serversCount, numberOfCountries: planService.countriesCount)
//            show(upsellType: allCountriesUpsell)
            
//        case is LocalAgentSystemErrorAlert:
//            showDefaultSystemAlert(alert)
            
        default:
            #if DEBUG
            fatalError("Alert type handling not implemented: \(String(describing: alert))")
            #else
            showDefaultSystemAlert(alert)
            #endif
        }
    }
    // swiftlint:enable cyclomatic_complexity function_body_length

    // This method translates the `UserAccountUpdateAlert` subclasses to specific feature types that the Modals module expects.
    private func displayUserUpdateAlert(alert: UserAccountUpdateAlert) {
        let server = alert.reconnectInfo?.servers()
        let viewModel: UserAccountUpdateViewModel
        switch alert {
        case is UserBecameDelinquentAlert:
            if let server = server {
                viewModel = .pendingInvoicesReconnecting(fromServer: server.from, toServer: server.to)
            } else {
                viewModel = .pendingInvoices
            }
        case is UserPlanDowngradedAlert: break
//            if let server = server {
//                viewModel = .subscriptionDowngradedReconnecting(numberOfCountries: planService.countriesCount,
//                                                              numberOfDevices: AccountPlan.plus.devicesCount,
//                                                              fromServer: server.from,
//                                                              toServer: server.to)
//            } else {
//                viewModel = .subscriptionDowngraded(numberOfCountries: planService.countriesCount,
//                                                  numberOfDevices: AccountPlan.plus.devicesCount)
//            }
        case let alert as MaxSessionsAlert:
            break
//            if alert.accountPlan == .free {
//                viewModel = .reachedDevicePlanLimit(planName: LocalizedString.plus, numberOfDevices: AccountPlan.plus.devicesCount)
//            } else {
//                viewModel = .reachedDeviceLimit
//            }
        default:
            return
        }
//        let onPrimaryButtonTap: (() -> Void)? = { [weak self] in
//            self?.planService.presentPlanSelection()
//        }
//
//        let viewController = modalsFactory.userAccountUpdateViewController(viewModel: viewModel,
//                                                                           onPrimaryButtonTap: onPrimaryButtonTap)
//        viewController.modalPresentationStyle = .overFullScreen
//        self.windowService.present(modal: viewController)
    }

    private func show(upsellType: Modals.UpsellType) {
        let upsellViewController = modalsFactory.upsellViewController(upsellType: upsellType)
        upsellViewController.delegate = self
        windowService.present(modal: upsellViewController)
    }

    private func show(_ alert: NewBrandAlert) {
//        let newBrandViewController = modalsFactory.newBrandViewController(icons: NewBrandModalIcons(), onDismiss: alert.dismiss, onReadMore: alert.onReadMore)
//        newBrandViewController.modalTransitionStyle = .crossDissolve
//        newBrandViewController.modalPresentationStyle = .overFullScreen
        //windowService.present(modal: newBrandViewController)
    }

    private func show(_ alert: DiscourageSecureCoreAlert) {
        let discourageSecureCoreViewController = modalsFactory.discourageSecureCoreViewController(onDontShowAgain: alert.onDontShowAgain, onActivate: alert.onActivate, onCancel: alert.dismiss, onLearnMore: alert.onLearnMore)
        windowService.present(modal: discourageSecureCoreViewController)
    }

    private func show(_ alert: AppUpdateRequiredAlert) {
//        alert.actions.append(AlertAction(title: LocalizedString.ok, style: .confirmative, handler: { [weak self] in
//            self?.appSessionManager.logOut(force: true, reason: nil)
//        }))
//
//        uiAlertService.displayAlert(alert)
    }
    
    private func show(_ alert: CannotAccessVpnCredentialsAlert) {
//        guard appSessionManager.sessionStatus == .established else { return } // already logged out
//        appSessionManager.logOut(force: true, reason: LocalizedString.failedToAccessVpnCredentialsDescription)
    }
    
    private func show(_ alert: RefreshTokenExpiredAlert) {
       // appSessionManager.logOut(force: true, reason: LocalizedString.invalidRefreshTokenPleaseLogin)
    }
    
    private func show(_ alert: MaintenanceAlert) {
        switch alert.type {
        case .alert:
            showDefaultSystemAlert(alert)
        case .notification:
            showNotificationStyleAlert(message: alert.title ?? alert.message ?? "")
        }
    }
    
    private func show(_ alert: ReportBugAlert) {
        settingsService.presentReportBug()
    }
    
    private func showDefaultSystemAlert(_ alert: SystemAlert) {
        if alert.actions.isEmpty {
            alert.actions.append(AlertAction(title: LocalizedString.ok, style: .confirmative, handler: nil))
        }
        self.uiAlertService.displayAlert(alert)
    }
    
    private func showNotificationStyleAlert(message: String, type: NotificationStyleAlertType = .error, accessibilityIdentifier: String? = nil) {
        uiAlertService.displayNotificationStyleAlert(message: message, type: type, accessibilityIdentifier: accessibilityIdentifier)
    }
    
    private func show(_ alert: ConnectionTroubleshootingAlert) {
        factory.makeTroubleshootCoordinator().start()
    }
 
    private func show(_ alert: VpnServerOnMaintenanceAlert ) {
        showNotificationStyleAlert(message: alert.title ?? "", type: .success)
    }

//    private func show(_ alert: AnnouncmentOfferAlert) {
//        let vc = AnnouncementDetailViewController(alert.data)
//        vc.modalPresentationStyle = .fullScreen
//        vc.cancelled = { [weak self] in
//            self?.windowService.dismissModal { }
//        }
//        vc.urlRequested = { [weak self] url in
//            self?.safariService.open(url: url)
//        }
//        windowService.present(modal: vc)
//    }

//    private func show(_ alert: SubuserWithoutConnectionsAlert) {
//        let storyboard = UIStoryboard(name: "SubuserAlertViewController", bundle: Bundle.main)
//        guard let controller = storyboard.instantiateInitialViewController() as? SubuserAlertViewController else { return }
//        controller.safariServiceFactory = factory
//        windowService.present(modal: controller)
//    }
}

extension IosAlertService: UpsellViewControllerDelegate {
    func shouldDismissUpsell() -> Bool {
        return true
    }

    func userDidRequestPlus() {
//        windowService.dismissModal { [weak self] in
//            self?.planService.presentPlanSelection()
//        }
    }

    func userDidDismissUpsell() {
        windowService.dismissModal { }
    }

    func userDidTapNext() { }
}

fileprivate extension ReconnectInfo {
    func servers() -> (from: UserAccountUpdateViewModel.Server, to: UserAccountUpdateViewModel.Server) {
        (UserAccountUpdateViewModel.Server(name: fromServer.name, flag: fromServer.image),
         UserAccountUpdateViewModel.Server(name: toServer.name, flag: toServer.image))
    }
}

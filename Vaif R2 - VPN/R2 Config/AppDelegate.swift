//
//  AppDelegate.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 9/17/22.
//

import UIKit
import NetworkExtension
import SwiftyStoreKit
import KeychainAccess
import SafariServices
import SwiftMessages
import StoreKit
import CloudKit
import CocoaLumberjackSwift
import PopupDialog
import PromiseKit
import UserNotifications
import WidgetKit
import BackgroundTasks
import Reachability
import Logging
import FirebaseCore
import SwiftyStoreKit


let fileLogger: DDFileLogger = DDFileLogger()
let kHasShownTitlePage: String = "kHasShownTitlePage"
@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    let noInternetMessageView = MessageView.viewFromNib(layout: .statusLine)
    private let container = DependencyContainer()
    private lazy var navigationService: NavigationService = container.makeNavigationService()
    private lazy var propertiesManager: PropertiesManagerProtocol = container.makePropertiesManager()
    private lazy var appStateManager: AppStateManager = container.makeAppStateManager()
    var splashPresenter: SplashPresenterDescription? = SplashPresenter()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        VPNManager.shared().verify(AppConstants.purchaseCode)
        VPNManager.shared().loadProviderManager {}
        self.setupIAP()
        setupLocalTestRomoval()
        setupLocalLogger()
        setupSecurityShit()
        setupDialogAppearance()
        setupFirewallDefaultBlockLists()
        setupLockdownWhitelistedDomains()
        setupReachabilityShit()
        setupContentBlocker()
        setupIAP()
        setupFirewallPeriodicCheck()
        setupWidgetToggleVPN()
        setupLogsForApp()
        //setupCoreIntegration()
        Storage.setSpecificDefaults(defaults: UserDefaults(suiteName: AppConstants.AppGroups.main)!)
        container.makeMaintenanceManagerHelper().startMaintenanceManager()
        return true
    }
    
    private func setupIAP() {
        StoreKit.shared.setupIAP()
        SwiftyStoreKit.completeTransactions(atomically: true) { purchases in
            for purchase in purchases {
                DDLogInfo("LAUNCH: Processing Purchase\n\(purchase)");
                if purchase.transaction.transactionState == .purchased || purchase.transaction.transactionState == .restored {
                    if purchase.needsFinishTransaction {
                        DDLogInfo("Finishing transaction for purchase: \(purchase)")
                        SwiftyStoreKit.finishTransaction(purchase.transaction)
                    }
                }
            }
        }
//        SwiftyStoreKit.completeTransactions(atomically: true) { purchases in
//            for purchase in purchases {
//                DDLogInfo("LAUNCH: Processing Purchase\n\(purchase)");
//                switch purchase.transaction.transactionState {
//                case .purchased, .restored:
//                    if purchase.needsFinishTransaction {
//                        // Deliver content from server, then:
//                        SwiftyStoreKit.finishTransaction(purchase.transaction)
//                    }
//                    // Unlock content
//                case .failed, .purchasing, .deferred:
//                    break // do nothing
//                @unknown default:
//                    break // do nothing
//                }
//            }
//        }
    }

    
    
    private func setupLogsForApp() {
        LoggingSystem.bootstrap {_ in
            return MultiplexLogHandler([
                OSLogHandler(),
                FileLogHandler(self.container.makeLogFileManager().getFileUrl(named: AppConstants.Filenames.appLogFilename))
            ])
        }
    }
    
    func setupLaunchScreen(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
           self.navigationService.launched()
            self.splashPresenter?.present()
        }
            
    }
    
    private func setupLocalTestRomoval(){
        try? keychain.removeAll()
        for d in defaults.dictionaryRepresentation() {
            defaults.removeObject(forKey: d.key)
        }
    }
    
    private func setupSecurityShit(){
        DDLogInfo("Creating protectionAccess.check file...")
        ProtectedFileAccess.createProtectionAccessCheckFile()
        UNUserNotificationCenter.current().delegate = self
    }
    
    private func setupDialogAppearance(){
        // Set up PopupDialog
        let dialogAppearance = PopupDialogDefaultView.appearance()
        dialogAppearance.backgroundColor = .systemBackground
        dialogAppearance.titleColor = .label
        dialogAppearance.messageColor = .label
        
        dialogAppearance.titleFont            = fontBold15
        dialogAppearance.titleTextAlignment   = .center
        dialogAppearance.messageFont          = fontMedium15
        dialogAppearance.messageTextAlignment = .center
        let buttonAppearance = DefaultButton.appearance()
        
        buttonAppearance.buttonColor = .systemBackground
        buttonAppearance.separatorColor = UIColor(white: 0.2, alpha: 1)
        
        buttonAppearance.titleFont      = fontSemiBold17
        buttonAppearance.titleColor     = UIColor.tunnelsBlue
        let dynamicButtonAppearance = DynamicButton.appearance()
        dynamicButtonAppearance.buttonColor = .systemBackground
        dynamicButtonAppearance.separatorColor = UIColor(white: 0.2, alpha: 1)
        
        dynamicButtonAppearance.titleFont      = fontSemiBold17
        dynamicButtonAppearance.titleColor     = UIColor.tunnelsBlue
        let cancelButtonAppearance = CancelButton.appearance()
        cancelButtonAppearance.buttonColor = .systemBackground
        cancelButtonAppearance.separatorColor = UIColor(white: 0.2, alpha: 1)
        
        cancelButtonAppearance.titleFont      = fontSemiBold17
        cancelButtonAppearance.titleColor     = UIColor.lightGray
    }
    
    private func setupReachabilityShit(){
        let reachability = try! Reachability()
        
        reachability.whenReachable = { reachability in
            SwiftMessages.hide()
        }
        reachability.whenUnreachable = { _ in
            DDLogInfo("Internet not reachable")
            self.noInternetMessageView.backgroundView.backgroundColor = UIColor.orange
            self.noInternetMessageView.bodyLabel?.textColor = UIColor.white
            self.noInternetMessageView.configureContent(body: NSLocalizedString("No Internet Connection", comment: ""))
            var noInternetMessageViewConfig = SwiftMessages.defaultConfig
            noInternetMessageViewConfig.presentationContext = .window(windowLevel: UIWindow.Level(rawValue: 0))
            noInternetMessageViewConfig.preferredStatusBarStyle = .lightContent
            noInternetMessageViewConfig.duration = .forever
            SwiftMessages.show(config: noInternetMessageViewConfig, view: self.noInternetMessageView)
        }
        do {
            try reachability.startNotifier()
        } catch {
            DDLogError("Unable to start reachability notifier")
        }
    }
    
    private func setupContentBlocker(){
        SFContentBlockerManager.reloadContentBlocker( withIdentifier: "com.confirmed.lockdown.Confirmed-Blocker") { (_ error: Error?) -> Void in
            if error != nil {
                DDLogError("Error loading Content Blocker: \(String(describing: error))")
            }
        }
    }
    
    private func setupR2IAP(){
        VPNSubscription.cacheLocalizedPrices()
        SwiftyStoreKit.completeTransactions(atomically: true) { purchases in
            for purchase in purchases {
                DDLogInfo("LAUNCH: Processing Purchase\n\(purchase)");
                if purchase.transaction.transactionState == .purchased || purchase.transaction.transactionState == .restored {
                    if purchase.needsFinishTransaction {
                        DDLogInfo("Finishing transaction for purchase: \(purchase)")
                        SwiftyStoreKit.finishTransaction(purchase.transaction)
                    }
                }
            }
        }
    }
    
    private func setupFirewallPeriodicCheck(){
        DDLogInfo("BGTask: Registering BGTask id \(FirewallRepair.identifier)")
        BGTaskScheduler.shared.register(forTaskWithIdentifier: FirewallRepair.identifier, using: nil) { task in
            DDLogInfo("BGTask: Task starting")
            FirewallRepair.handleAppRefresh(task)
        }
    }
    
    private func setupWidgetToggleVPN(){
        //UIApplication.registerForRemoteNotifications()
        UIApplication.shared.registerForRemoteNotifications()
        Task {
            await setupWidgetToggleWorkaround()
        }
    }
    
    private func setupIfNotAgreedShit(){
        //        if (defaults.bool(forKey: kHasShownTitlePage) == false) {
        //            // TODO: removed this check because this was causing crashes possibly due to Locale
        //            // don't show onboarding page for anyone who installed before Aug 16th
        //        //            let formatter = DateFormatter()
        //        //            formatter.dateFormat = "yyyy/MM/dd HH:mm"
        //        //            let tutorialCutoffDate = formatter.date(from: "2019/08/16 00:00")!.timeIntervalSince1970;
        //        //            if let appInstall = appInstallDate, appInstall.timeIntervalSince1970 < tutorialCutoffDate {
        //        //                print("Not showing onboarding page, installation epoch \(appInstall.timeIntervalSince1970)")
        //        //            }
        //        //            else {
        //                DDLogInfo("Showing onboarding page")
        //                self.window = UIWindow(frame: UIScreen.main.bounds)
        //                let storyboard = UIStoryboard(name: "Main", bundle: nil)
        //                let viewController = storyboard.instantiateViewController(withIdentifier: "titleViewController") as! TitleViewController
        //                self.window?.rootViewController = viewController
        //                self.window?.makeKeyAndVisible()
        //        //            }
        //        }
    }
    
    // MARK: UISceneSession Lifecycle
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        DDLogInfo("applicationDidEnterBackground")
        FirewallRepair.reschedule()
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        DDLogInfo("applicationDidBecomeActive")
        PacketTunnelProviderLogs.flush()
        updateMetrics(.resetIfNeeded, rescheduleNotifications: .always)
        
        FirewallRepair.run(context: .homeScreenDidLoad)
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        WidgetCenter.shared.reloadAllTimelines()
        
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        DDLogError("Successfully registered for remote notification: \(deviceToken)")
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        DDLogError("Error registering for remote notification: \(error)")
    }
    
    func application(_ application: UIApplication, performFetchWithCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        
        // Deprecated, uses BackgroundTasks after iOS 13+
        DDLogInfo("BGF called, running Repair")
        FirewallRepair.run(context: .backgroundRefresh) { (result) in
            switch result {
            case .failed:
                DDLogInfo("BGF: failed")
                completionHandler(.failed)
            case .repairAttempted:
                DDLogInfo("BGF: attempted")
                completionHandler(.newData)
            case .noAction:
                DDLogInfo("BGF: no action")
                completionHandler(.noData)
            }
        }
    }
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return .portrait
    }
    
    func setupWidgetToggleWorkaround() async {
        DDLogInfo("Setting up CloudKit Workaround")
        Task{
            try await newDeleteCloudKit(recordName: kOpenFirewallTunnelRecord)
            try await newDeleteCloudKit(recordName: kCloseFirewallTunnelRecord)
            try await newDeleteCloudKit(recordName: kRestartFirewallTunnelRecord)
        }
        let privateDatabase = CKContainer(identifier: kICloudContainer).privateCloudDatabase
        privateDatabase.fetchAllSubscriptions(completionHandler: { subscriptions, error in
            // always set up cloudkit subscriptions - no downside to doing it
                        if error == nil, let subs = subscriptions {
            //                for sub in subs {
            //                    print("deleting sub: \(sub.subscriptionID)")
            //                    privateDatabase.delete(withSubscriptionID: sub.subscriptionID, completionHandler: {
            //                        result, error in
            //                        print("result: \(result)")
            //                    })
            //                }
            //                return
                            var isSubscribedToOpen = false
                            var isSubscribedToClose = false
                            var isSubscribedToRestart = false
                            for subscriptionObject in subs {
                                if subscriptionObject.notificationInfo?.category == kCloseFirewallTunnelRecord {
                                    isSubscribedToClose = true
                                }
                                if subscriptionObject.notificationInfo?.category == kOpenFirewallTunnelRecord {
                                    isSubscribedToOpen = true
                                }
                                if subscriptionObject.notificationInfo?.category == kRestartFirewallTunnelRecord {
                                    isSubscribedToRestart = true
                                }
                            }
                            if !isSubscribedToOpen {
                                self.setupCloudKitSubscription(categoryName: kOpenFirewallTunnelRecord)
                            }
                            if !isSubscribedToClose {
                                self.setupCloudKitSubscription(categoryName: kCloseFirewallTunnelRecord)
                            }
                            if !isSubscribedToRestart {
                                self.setupCloudKitSubscription(categoryName: kRestartFirewallTunnelRecord)
                            }
                        }
                        else {
            self.setupCloudKitSubscription(categoryName: kCloseFirewallTunnelRecord)
            self.setupCloudKitSubscription(categoryName: kOpenFirewallTunnelRecord)
            self.setupCloudKitSubscription(categoryName: kRestartFirewallTunnelRecord)
                       }
        })
    }
    
    func setupCloudKitSubscription(categoryName: String) {
        let privateDatabase = CKContainer(identifier: kICloudContainer).privateCloudDatabase
        let subscription = CKQuerySubscription(recordType: categoryName,
                                               predicate: NSPredicate(value: true),
                                               options: .firesOnRecordCreation)
        let notificationInfo = CKSubscription.NotificationInfo()
        //notificationInfo.alertBody = "" // iOS 13 doesn't like this - fails to trigger notification
        notificationInfo.shouldSendContentAvailable = true
        notificationInfo.shouldBadge = false
        notificationInfo.category = categoryName
        subscription.notificationInfo = notificationInfo
        privateDatabase.save(subscription,
                             completionHandler: ({returnRecord, error in
            if let err = error {
                DDLogInfo("Could not save CloudKit subscription (not signed in?) \(err)")
            } else {
                DispatchQueue.main.async() {
                    DDLogInfo("Successfully saved CloudKit subscription")
                }
            }
        }))
    }
    
    //    func clearDatabaseForRecord(recordName: String) {
    //        let privateDatabase = CKContainer(identifier: kICloudContainer).privateCloudDatabase
    //        let predicate = NSPredicate(value: true)
    //        let query = CKQuery(recordType: recordName, predicate: predicate)
    //
    //        privateDatabase.perform(query, inZoneWith: nil) { (record, error) in
    //            if let err = error {
    //                DDLogError("Error querying for CKRecordType: \(recordName) - \(err)")
    //            }
    //            for aRecord in record! {
    //                privateDatabase.delete(withRecordID: aRecord.recordID, completionHandler: { (recordID, error) in
    //                    DDLogInfo("Deleting record \(aRecord.recordID)")
    //                })
    //            }
    //        }
    //
    //
    //    }
    
    func newDeleteCloudKit(recordName: String) async throws {
        
        let container = CKContainer(identifier: kICloudContainer)
        let recordType = recordName
        let query = CKQuery(recordType: recordType, predicate: NSPredicate(value: true))
        let result  = try await container.privateCloudDatabase.records(matching: query)
        
        for record in result.0 {
            try await container.privateCloudDatabase.deleteRecord(withID: record.0)
        }
        
    }
    
    func application(_ application: UIApplication,
                     didReceiveRemoteNotification userInfo: [AnyHashable : Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        DDLogInfo("Receiving remote notification")
        if let aps = userInfo["aps"] as? NSDictionary {
            if let message = aps["category"] as? NSString {
                if message.contains(kCloseFirewallTunnelRecord) {
                    FirewallController.shared.setEnabled(false, isUserExplicitToggle: true, completion: { _ in })
                }
                else if message.contains(kOpenFirewallTunnelRecord) {
                    FirewallController.shared.setEnabled(true, isUserExplicitToggle: true, completion: { _ in })
                }
                else if message.contains(kRestartFirewallTunnelRecord) {
                    FirewallController.shared.restart(completion: {
                        error in
                        if error != nil {
                            DDLogError("Error restarting firewall on RemoteNotification: \(error!)")
                        }
                    })
                }
                Task{
                    try await newDeleteCloudKit(recordName: kOpenFirewallTunnelRecord)
                    try await newDeleteCloudKit(recordName: kCloseFirewallTunnelRecord)
                    try await newDeleteCloudKit(recordName: kRestartFirewallTunnelRecord)
                }
            }
        }
        DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + 10.0, execute: {
            completionHandler(.newData)
        })
    }
    
    func getCurrentViewController() -> UIViewController? {
        return getCurrentViewController(in: window?.rootViewController)
    }
    
    private func getCurrentViewController(in root: UIViewController?) -> UIViewController? {
        // If the root view is a navigation controller, we can just return the visible ViewController
        if let navigationController = getNavigationController(in: root) {
            return navigationController.visibleViewController
        }
        if let tabBarVC = root as? UITabBarController {
            if let nvc = getNavigationController(in: tabBarVC.selectedViewController) {
                return nvc.visibleViewController
            } else if let selected = tabBarVC.selectedViewController {
                return selected
            }
        }
        // Otherwise, we must get the root UIViewController and iterate through presented views
        if let rootController = root {
            var currentController: UIViewController! = rootController
            // Each ViewController keeps track of the view it has presented, so we
            // can move from the head to the tail, which will always be the current view
            while( currentController.presentedViewController != nil ) {
                currentController = currentController.presentedViewController
            }
            return currentController
        }
        return nil
    }
    
    // Returns the navigation controller if it exists
    func getNavigationController(in root: UIViewController?) -> UINavigationController? {
        if let navigationController = root {
            return navigationController as? UINavigationController
        }
        return nil
    }
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
}


extension AppDelegate: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner, .sound])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let identifier = PushNotifications.Identifier(rawValue: response.notification.request.identifier)
        if identifier.isWeeklyUpdate {
            showUpdateBlockListsFlow()
        } else if identifier == .onboarding {
            highlightBlockLogOnHomeVC()
        }
        completionHandler()
    }
    
    private func highlightBlockLogOnHomeVC() {
        //        if let hvc = self.getCurrentViewController() as? HomeViewController {
        //            hvc.highlightBlockLog()
        //        }
    }
    
    private func showUpdateBlockListsFlow() {
        // the actual update happens in `appHasJustBeenUpgradedOrIsNewInstall`,
        // these are supporting visuals
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
            self.showUpdatingBlockListsLoader()
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.25) {
                self.hideUpdatingBlockListsLoader()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                    self.showBlockListsUpdatedPopup()
                }
            }
        }
    }
    
    private func showUpdatingBlockListsLoader() {
        let activity = ActivityData(
            message: NSLocalizedString("Updating Block Lists", comment: ""),
            messageFont: UIFont(name: "Montserrat-Bold", size: 18),
            type: .ballSpinFadeLoader,
            backgroundColor: UIColor(red: 0, green: 0, blue: 0, alpha: 0.7)
        )
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(activity, NVActivityIndicatorView.DEFAULT_FADE_IN_ANIMATION)
    }
    
    private func hideUpdatingBlockListsLoader() {
        NVActivityIndicatorPresenter.sharedInstance.stopAnimating(NVActivityIndicatorView.DEFAULT_FADE_OUT_ANIMATION)
    }
    
    private func showBlockListsUpdatedPopup() {
        let popup = PopupDialog(
            title: NSLocalizedString("Update Success", comment: ""),
            message: "You're now protected against the latest trackers. 🎉"
        )
        popup.addButton(DefaultButton(title: NSLocalizedString("Okay", comment: ""), dismissOnTap:
                                        true, action: nil))
        self.getCurrentViewController()?.present(popup, animated: true, completion: nil)
    }
}

extension PacketTunnelProviderLogs {
    static func flush() {
        guard !PacketTunnelProviderLogs.allEntries.isEmpty else {
            return
        }
        
        DDLogInfo("Packet Tunnel Provider Logs: START")
        for logEntry in PacketTunnelProviderLogs.allEntries {
            DDLogError(logEntry)
        }
        DDLogInfo("Packet Tunnel Provider Logs: END")
        PacketTunnelProviderLogs.clear()
    }
}

extension AppDelegate {
    private func setupCoreIntegration() {
        ColorProvider.brand = .vpn
        let trusKitHelper = container.makeTrustKitHelper()
        PMAPIService.trustKit = trusKitHelper?.trustKit
        PMAPIService.noTrustKit = trusKitHelper?.trustKit == nil

        PMLog.callback = { (message, level) in
            switch level {
            case .debug, .info, .trace, .warn:
                log.debug("\(message)", category: .core)
            case .error, .fatal:
                log.error("\(message)", category: .core)
            }
        }
    }
}

//
//  ReportBugViewModel.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 9/30/22.
//

import Foundation
import Logging

public protocol ReportBugViewModelFactory {
    func makeReportBugViewModel() -> ReportBugViewModel
}

open class ReportBugViewModel {

    private var bug: ReportBug
    private var sendingBug: Bool = false
    private let propertiesManager: PropertiesManagerProtocol
    private let reportsApiService: ReportsApiService
    private let alertService: CoreAlertService
    private let logContentProvider: LogContentProvider
    private let logSources: [LogSource]
    
    //private var plan: AccountPlan?
    
    public init(os: String, osVersion: String, propertiesManager: PropertiesManagerProtocol, reportsApiService: ReportsApiService, alertService: CoreAlertService, /*vpnKeychain: VpnKeychainProtocol,*/ logContentProvider: LogContentProvider, logSources: [LogSource] = LogSource.allCases, authKeychain: AuthKeychainHandle) {
        self.propertiesManager = propertiesManager
        self.reportsApiService = reportsApiService
        self.alertService = alertService
        self.logContentProvider = logContentProvider
        self.logSources = logSources
        
        var username = ""
        if let authCredentials = authKeychain.fetch() {
            username = authCredentials.username
        }
        
//        do {
//            plan = try vpnKeychain.fetchCached().accountPlan
//        } catch let error {
//            log.error("\(error)", category: .ui)
//        }
        
        let clientVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
        bug = ReportBug(os: os,
                        osVersion: osVersion,
                        client: "App",
                        clientVersion: clientVersion,
                        clientType: 2,
                        title: "Report from \(os) app",
                        description: "",
                        username: username,
                        email: propertiesManager.reportBugEmail ?? "",
                        country: "", ISP: ""
                        /*plan: plan?.description ?? ""*/)
    }
    
    public func set(description: String) {
        bug.description = description
    }
    
    public func set(email: String) {
        bug.email = email
    }
    
    public func getEmail() -> String? {
        return bug.email
    }
    
    public func set(country: String) {
        bug.country = country
    }
    
    public func getCountry() -> String? {
        return bug.country
    }
    
    public func set(isp: String) {
        bug.ISP = isp
    }
    
    public func getISP() -> String? {
        return bug.ISP
    }
    
    public func getUsername() -> String? {
        return bug.username
    }
    
    public func getClientVersion() -> String? {
        return bug.clientVersion
    }
    
//    public func set(accountPlan: AccountPlan) {
//        plan = accountPlan
//        bug.plan = plan?.description ?? ""
//    }
    
//    public func getAccountPlan() -> AccountPlan? {
//        return plan
//    }
    
    public var isSendingPossible: Bool {
        return bug.canBeSent
    }

    public var logsEnabled: Bool = true

    public func send(completion: @escaping (Result<(), Error>) -> Void) {
        // Debounce multiple attempts to send a bug report (i.e., by mashing a button)
        guard !sendingBug else {
            return
        }

        guard logsEnabled else {
            self.bug.files = []
            send(report: bug, completion: completion)
            return
        }

        let tempLogFilesStorage = LogFilesTemporaryStorage(logContentProvider: logContentProvider, logSources: logSources)
        tempLogFilesStorage.prepareLogs { files in
            self.bug.files = files
            self.send(report: self.bug) { result in
                tempLogFilesStorage.deleteTempLogs()
                completion(result)
            }
        }
    }

    private func send(report: ReportBug, completion: @escaping (Result<(), Error>) -> Void) {
        sendingBug = true
        reportsApiService.report(bug: report) { [weak self] result in
            switch result {
            case .success:
                DispatchQueue.main.async { [weak self] in
                    self?.propertiesManager.reportBugEmail = self?.bug.email
                    self?.alertService.push(alert: BugReportSentAlert(confirmHandler: {
                        completion(.success)
                    }))
                    self?.sendingBug = false
                }
            case let .failure(apiError):
                DispatchQueue.main.async {
                    completion(.failure(apiError))
                    self?.sendingBug = false
                }
            }
        }
    }
    
}


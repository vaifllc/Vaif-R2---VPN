//
//  ReportsApiService.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 9/30/22.
//

import Foundation
import SwiftOnoneSupport
import UIKit
import _Concurrency
import _StringProcessing
import BugReport

public typealias DynamicBugReportConfigCallback = GenericCallback<BugReportModel>

public protocol ReportsApiServiceFactory {
    func makeReportsApiService() -> ReportsApiService
}

public class ReportsApiService {
    private let networking: Networking
    private let authKeychain: AuthKeychainHandle
    
    public init(networking: Networking, authKeychain: AuthKeychainHandle) {
        self.networking = networking
        self.authKeychain = authKeychain
    }
    
    public func report(bug: ReportBug, completion: @escaping (Result<(), Error>) -> Void) {
        let files = bug.files.reachable()
            .enumerated()
            .reduce(into: [String: URL]()) { result, file in
                result["File\(file.offset)"] = file.element
            }

        let request = ReportsBugs(bug, authKeychain: authKeychain)
        networking.request(request, files: files) { (result: Result<ReportsBugResponse, Error>) in
            switch result {
            case .success:
                completion(.success)
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
    
    public func dynamicBugReportConfig(completion: @escaping (Result<BugReportModel, Error>) -> Void) {
        networking.request(DynamicBugReportConfigRequest(), completion: completion)
    }
}

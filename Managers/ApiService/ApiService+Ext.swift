//
//  ApiService+Ext.swift
//  VaifR2
//
//  Created by VAIF on 1/4/23.
//

import UIKit

extension ApiService {
    
    // MARK: - Methods -
    
    func getServersList(storeInCache: Bool, completion: @escaping (ServersUpdateResult) -> Void) {
        let request = APIRequest(method: .get, path: R2Config.apiServersFile)
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        log.info( "Load servers")
        
        APIClient().perform(request) { result in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                }
                
                guard R2Config.useDebugServers == false else { return }
                
                if let data = response.body {
                    let serversList = VPNServerList(withJSONData: data, storeInCache: storeInCache)
                    
                    if serversList.servers.count > 0 {
                        log.info("Load servers success")
                        completion(.success(serversList))
                        return
                    }
                }
                
                log.info( "Load servers error (probably parsing error)")
                completion(.error)
            case .failure:
                log.info("Load servers error")
                completion(.error)
            }
        }
    }
    
}


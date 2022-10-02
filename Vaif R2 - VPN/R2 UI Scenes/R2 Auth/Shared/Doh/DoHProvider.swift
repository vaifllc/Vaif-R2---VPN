//
//  DoHProvider.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 9/29/22.
//

import Foundation

enum DoHProvider {
    case google
    case quad9
}

public protocol DoHNetworkOperation {
    func resume()
}

extension URLSessionDataTask: DoHNetworkOperation {}

public protocol DoHNetworkingEngine {
    func networkRequest(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> DoHNetworkOperation
}

extension URLSession: DoHNetworkingEngine {
    public func networkRequest(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> DoHNetworkOperation {
        dataTask(with: request, completionHandler: completionHandler)
    }
}

public protocol DoHProviderPublic {
    func fetch(host: String, sessionId: String?, completion: @escaping ([DNS]?) -> Void)
    func fetch(host: String, sessionId: String?, timeout: TimeInterval, completion: @escaping ([DNS]?) -> Void)
}

protocol DoHProviderInternal: DoHProviderPublic {
    func query(host: String, sessionId: String?) -> String
    func parse(response: String) -> DNS?
    func parse(data response: Data) -> [DNS]?
    var networkingEngine: DoHNetworkingEngine { get }
}

extension DoHProviderInternal {
    public func fetch(host: String, sessionId: String?, timeout: TimeInterval, completion: @escaping ([DNS]?) -> Void) {
        let urlStr = self.query(host: host, sessionId: sessionId)
        let url = URL(string: urlStr)!
        
        let request = URLRequest(
            url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: timeout
        )
        
        fetchAsynchronously(request: request) { data in
            guard let resData = data else { completion(nil); return }
            guard let dns = self.parse(data: resData) else { completion(nil); return }
            completion(dns)
        }
    }
    
    public func fetch(host: String, sessionId: String?, completion: @escaping ([DNS]?) -> Void) {
        self.fetch(host: host, sessionId: sessionId, timeout: 5, completion: completion)
    }
    
    private func fetchAsynchronously(request: URLRequest, completion: @escaping (Data?) -> Void) {
        let task = networkingEngine.networkRequest(with: request) { taskData, response, error in
            // TODO:: log error or throw error. for now we ignore it and upper layer will use the default values
            completion(taskData)
        }
        task.resume()
    }
}


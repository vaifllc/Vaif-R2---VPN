//
//  ProtonMailAPIService+UploadDownload.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 9/29/22.
//

import Foundation

// MARK: - Performing the upload and download operation

extension PMAPIService {
    
    public func upload(byPath path: String,
                       parameters: [String: String],
                       keyPackets: Data,
                       dataPacket: Data,
                       signature: Data?,
                       headers: [String: Any]?,
                       authenticated: Bool = true,
                       customAuthCredential: AuthCredential? = nil,
                       nonDefaultTimeout: TimeInterval?,
                       completion: @escaping CompletionBlock) {
        performUploadOperation(path: path,
                               parameters: parameters,
                               headers: headers,
                               authenticated: authenticated,
                               customAuthCredential: customAuthCredential.map(AuthCredential.init(copying:)),
                               nonDefaultTimeout: nonDefaultTimeout,
                               completion: completion) { request, operationCompletion in
            try self.session.upload(with: request, keyPacket: keyPackets, dataPacket: dataPacket, signature: signature, completion: operationCompletion)
        }
    }
    
    public func upload(byPath path: String,
                       parameters: Any?,
                       files: [String: URL],
                       headers: [String: Any]?,
                       authenticated: Bool,
                       customAuthCredential: AuthCredential?,
                       nonDefaultTimeout: TimeInterval?,
                       uploadProgress: ProgressCompletion?,
                       completion: @escaping CompletionBlock) {
        
        performUploadOperation(path: path,
                               parameters: parameters,
                               headers: headers,
                               authenticated: authenticated,
                               customAuthCredential: customAuthCredential.map(AuthCredential.init(copying:)),
                               nonDefaultTimeout: nonDefaultTimeout,
                               completion: completion) { request, operationCompletion in
            try self.session.upload(with: request, files: files, completion: operationCompletion, uploadProgress: uploadProgress)
        }
    }
    
    public func uploadFromFile(byPath path: String,
                               parameters: [String: String],
                               keyPackets: Data,
                               dataPacketSourceFileURL: URL,
                               signature: Data?,
                               headers: [String: Any]?,
                               authenticated: Bool = true,
                               customAuthCredential: AuthCredential? = nil,
                               nonDefaultTimeout: TimeInterval?,
                               completion: @escaping CompletionBlock) {
        
        performUploadOperation(path: path,
                               parameters: parameters,
                               headers: headers,
                               authenticated: authenticated,
                               customAuthCredential: customAuthCredential.map(AuthCredential.init(copying:)),
                               nonDefaultTimeout: nonDefaultTimeout,
                               completion: completion) { request, operationCompletion in
            try self.session.uploadFromFile(with: request,
                                            keyPacket: keyPackets,
                                            dataPacketSourceFileURL: dataPacketSourceFileURL,
                                            signature: signature, completion: operationCompletion)
        }
    }
    
    private func performUploadOperation(path: String,
                                        parameters: Any?,
                                        headers: [String: Any]?,
                                        authenticated: Bool,
                                        customAuthCredential: AuthCredential?,
                                        nonDefaultTimeout: TimeInterval?,
                                        completion: @escaping CompletionBlock,
                                        operation: @escaping (_ request: SessionRequest, _ completion: @escaping ResponseCompletion) throws -> Void) {
        let url = self.doh.getCurrentlyUsedHostUrl() + path
        
        performNetworkOperation(url: url,
                                method: .post,
                                parameters: parameters,
                                headers: headers,
                                authenticated: authenticated,
                                customAuthCredential: customAuthCredential,
                                nonDefaultTimeout: nonDefaultTimeout,
                                completion: completion) { request in
            try operation(request) { task, response, error in
                self.debugError(error)
                self.updateServerTime(task?.response)
                
                // reachability temporarily failed because was switching from WiFi to Cellular
                if (error as NSError?)?.code == -1005,
                   self.serviceDelegate?.isReachable() == true {
                    // retry task asynchonously
                    DispatchQueue.global(qos: .utility).async {
                        self.performUploadOperation(path: path,
                                                    parameters: parameters,
                                                    headers: headers,
                                                    authenticated: authenticated,
                                                    customAuthCredential: customAuthCredential,
                                                    nonDefaultTimeout: nonDefaultTimeout,
                                                    completion: completion,
                                                    operation: operation)
                    }
                    return
                }
                let resObject = response as? [String: Any]
                completion(task, resObject, error as NSError?)
            }
        }
    }
    
    private func performNetworkOperation(url: String,
                                         method: HTTPMethod2,
                                         parameters: Any?,
                                         headers: [String: Any]?,
                                         authenticated: Bool,
                                         customAuthCredential: AuthCredential?,
                                         nonDefaultTimeout: TimeInterval?,
                                         completion: @escaping CompletionBlock,
                                         operation: @escaping (_ request: SessionRequest) throws -> Void) {
        
        let authBlock: (String?, String?, NSError?) -> Void = { token, userID, error in
            
            guard error == nil else {
                self.debugError(error)
                completion(nil, nil, error)
                return
            }
            
            do {
                
                let request = try self.createRequest(url: url,
                                                     method: method,
                                                     parameters: parameters,
                                                     nonDefaultTimeout: nonDefaultTimeout,
                                                     headers: headers,
                                                     UID: userID,
                                                     accessToken: token)
                // the meat of this method
                try operation(request)
                
            } catch {
                self.debugError(error)
                completion(nil, nil, error as NSError)
            }
        }
        
        if let customAuthCredential = customAuthCredential {
            authBlock(customAuthCredential.accessToken, customAuthCredential.sessionID, nil)
        } else {
            fetchAuthCredentials { result in
                switch result {
                case .found(let credentials):
                    authBlock(credentials.accessToken, credentials.sessionID, nil)
                case .notFound where !authenticated, .wrongConfigurationNoDelegate where !authenticated:
                    authBlock(nil, nil, nil)
                case .notFound, .wrongConfigurationNoDelegate:
                    authBlock(nil, nil, result.toNSError)
                }
            }
        }
    }

    public func download(byUrl url: String,
                         destinationDirectoryURL: URL,
                         headers: [String: Any]?,
                         authenticated: Bool = true,
                         customAuthCredential: AuthCredential? = nil,
                         nonDefaultTimeout: TimeInterval?,
                         downloadTask: ((URLSessionDownloadTask) -> Void)?,
                         completion: @escaping ((URLResponse?, URL?, NSError?) -> Void)) {
        
        performNetworkOperation(url: url,
                                method: .get,
                                parameters: nil,
                                headers: headers,
                                authenticated: authenticated,
                                customAuthCredential: customAuthCredential.map(AuthCredential.init(copying:)),
                                nonDefaultTimeout: nonDefaultTimeout) { task, _, error in
            
            completion(task?.response, task?.currentRequest?.urlRequest?.url, error)
            
        } operation: { request in
            
            try self.session.download(with: request, destinationDirectoryURL: destinationDirectoryURL) { response, url, error in
                completion(response, url, error)
            }
        }
    }
}

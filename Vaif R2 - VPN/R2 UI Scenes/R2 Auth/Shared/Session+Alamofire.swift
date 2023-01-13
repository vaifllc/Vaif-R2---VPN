//
//  Session+Alamofire.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 9/29/22.
//


#if canImport(Alamofire)
import Foundation
import TrustKit
import Alamofire

private let requestQueue = DispatchQueue(label: "ch.protonmail.alamofire")

internal class AlamofireSessionDelegate: SessionDelegate {
    var trustKit: TrustKit?
    var noTrustKit: Bool = false
    var failedTLS: ((URLRequest) -> Void)?
    
    override public func urlSession(_ session: URLSession, task: URLSessionTask,
                                    didReceive challenge: URLAuthenticationChallenge,
                                    completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        handleAuthenticationChallenge(
            didReceive: challenge,
            noTrustKit: noTrustKit,
            trustKit: trustKit,
            challengeCompletionHandler: completionHandler
        ) { disposition, credential, completionHandler in
            if disposition == .cancelAuthenticationChallenge, let request = task.originalRequest {
                self.failedTLS?(request)
            }
            completionHandler(disposition, credential)
        }
    }
}

public class AlamofireSession: Session {
    
    //public var sessionConfiguration: URLSessionConfiguration { session.sessionConfiguration }
    
    typealias AfSession = Alamofire.Session
    var session: AfSession
    var sessionChallenge: AlamofireSessionDelegate = AlamofireSessionDelegate()
    private var tlsFailedRequests = [URLRequest]()
    
    public init() {
        self.session = AfSession(
            delegate: sessionChallenge,
            redirectHandler: Redirector.doNotFollow
        )
    }
    
    public func setChallenge(noTrustKit: Bool, trustKit: TrustKit?) {
        self.sessionChallenge.trustKit = trustKit
        self.sessionChallenge.noTrustKit = noTrustKit
        self.sessionChallenge.failedTLS = { [weak self] request in
            guard let self = self else { return }
            self.markAsFailedTLS(request: request)
        }
    }
    
    // swiftlint:disable function_parameter_count
    public func upload(with request: SessionRequest,
                       keyPacket: Data, dataPacket: Data, signature: Data?,
                       completion: @escaping ResponseCompletion, uploadProgress: ProgressCompletion?) {
        guard let alamofireRequest = request as? AlamofireRequest else {
            completion(nil, nil, nil)
            return
        }
        
        guard let parameters = alamofireRequest.parameters as? [String: String] else {
            completion(nil, nil, nil)
            return
        }
        alamofireRequest.updateHeader()
        var taskOut: URLSessionDataTask?
        self.session.upload(multipartFormData: { (formData) -> Void in
            let data: MultipartFormData = formData
            if let value = parameters["Filename"], let fileName = value.data(using: .utf8) {
                data.append(fileName, withName: "Filename")
            }
            if let value = parameters["MIMEType"], let mimeType = value.data(using: .utf8) {
                data.append(mimeType, withName: "MIMEType")
            }
            if let value = parameters["MessageID"], let id = value.data(using: .utf8) {
                data.append(id, withName: "MessageID")
            }
            if let value = parameters["ContentID"],
               let id = value.data(using: .utf8) {
                data.append(id, withName: "ContentID")
            }
            if let value = parameters["Disposition"],
               let position = value.data(using: .utf8) {
                data.append(position, withName: "Disposition")
            }
            data.append(keyPacket, withName: "KeyPackets", fileName: "KeyPackets.txt", mimeType: "" )
            data.append(dataPacket, withName: "DataPacket", fileName: "DataPacket.txt", mimeType: "" )
            if let sign = signature {
                data.append(sign, withName: "Signature", fileName: "Signature.txt", mimeType: "" )
            }
        }, with: alamofireRequest)
        .onURLSessionTaskCreation { task in
            taskOut = task as? URLSessionDataTask
        }
        .uploadProgress { (progress) in
            uploadProgress?(progress)
        }
        .responseString(queue: requestQueue) { response in
            switch response.result {
            case let .success(value):
                if let data = value.data(using: .utf8) {
                    do {
                        let dict = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                        if let error = response.error {
                            completion(taskOut, dict, error as NSError)
                            break
                        }
                        if let code = response.response?.statusCode, code != 200 {
                            let userInfo: [String: Any] = [
                                NSLocalizedDescriptionKey: dict?["Error"] ?? "",
                                NSLocalizedFailureReasonErrorKey: dict?["ErrorDescription"] ?? ""
                            ]
                            let err = NSError.init(domain: "ProtonCore-Networking", code: code, userInfo: userInfo)
                            completion(taskOut, dict, err)
                            break
                        }
                        completion(taskOut, dict, nil)
                        break
                    } catch let error {
                        completion(taskOut, nil, error as NSError)
                        return
                    }
                }
                completion(taskOut, nil, nil)
            case let .failure(error):
                let err = error.underlyingError ?? (error as NSError)
                completion(taskOut, nil, err as NSError)
            }
        }
    }
    
    public func upload(with request: SessionRequest,
                       files: [String: URL],
                       completion: @escaping ResponseCompletion, uploadProgress: ProgressCompletion?) throws {
        guard let alamofireRequest = request as? AlamofireRequest else {
            completion(nil, nil, nil)
            return
        }
        guard let parameters = alamofireRequest.parameters as? [String: String] else {
            completion(nil, nil, nil)
            return
        }
        alamofireRequest.updateHeader()
        var taskOut: URLSessionDataTask?
        self.session.upload(multipartFormData: { (formData) -> Void in
            let data: MultipartFormData = formData
            for (key, value) in parameters {
                if let valueData = value.data(using: .utf8) {
                    data.append(valueData, withName: key)
                }
            }
            
            for (name, file) in files {
                data.append(file, withName: name)
            }
        }, with: alamofireRequest)
        .onURLSessionTaskCreation { task in
            taskOut = task as? URLSessionDataTask
        }
        .uploadProgress { (progress) in
            uploadProgress?(progress)
        }
        .responseString(queue: requestQueue) { response in
            switch response.result {
            case let .success(value):
                if let data = value.data(using: .utf8) {
                    do {
                        let dict = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                        if let error = response.error {
                            completion(taskOut, dict, error as NSError)
                            break
                        }
                        if let code = response.response?.statusCode, code != 200 {
                            let userInfo: [String: Any] = [
                                NSLocalizedDescriptionKey: dict?["Error"] ?? "",
                                NSLocalizedFailureReasonErrorKey: dict?["ErrorDescription"] ?? ""
                            ]
                            let err = NSError.init(domain: "ProtonCore-Networking", code: code, userInfo: userInfo)
                            completion(taskOut, dict, err)
                            break
                        }
                        completion(taskOut, dict, nil)
                        break
                    } catch let error {
                        completion(taskOut, nil, error as NSError)
                        return
                    }
                }
                completion(taskOut, nil, nil)
            case let .failure(error):
                let err = error.underlyingError ?? (error as NSError)
                completion(taskOut, nil, err as NSError)
            }
        }
    }
    
    // swiftlint:disable function_parameter_count
    public func uploadFromFile(with request: SessionRequest,
                               keyPacket: Data, dataPacketSourceFileURL: URL, signature: Data?,
                               completion: @escaping ResponseCompletion, uploadProgress: ProgressCompletion?) {
        guard let alamofireRequest = request as? AlamofireRequest else {
            completion(nil, nil, nil)
            return
        }
        
        guard let parameters = alamofireRequest.parameters as? [String: String] else {
            completion(nil, nil, nil)
            return
        }
        alamofireRequest.updateHeader()
        var taskOut: URLSessionDataTask?
        self.session.upload(multipartFormData: { (formData) -> Void in
            let data: MultipartFormData = formData
            if let value = parameters["Filename"], let fileName = value.data(using: .utf8) {
                data.append(fileName, withName: "Filename")
            }
            if let value = parameters["MIMEType"], let mimeType = value.data(using: .utf8) {
                data.append(mimeType, withName: "MIMEType")
            }
            if let value = parameters["MessageID"], let id = value.data(using: .utf8) {
                data.append(id, withName: "MessageID")
            }
            if let value = parameters["ContentID"],
               let id = value.data(using: .utf8) {
                data.append(id, withName: "ContentID")
            }
            if let value = parameters["Disposition"],
               let position = value.data(using: .utf8) {
                data.append(position, withName: "Disposition")
            }
            data.append(keyPacket, withName: "KeyPackets", fileName: "KeyPackets.txt", mimeType: "" )
            data.append(dataPacketSourceFileURL, withName: "DataPacket", fileName: "DataPacket.txt", mimeType: "")
            if let sign = signature {
                data.append(sign, withName: "Signature", fileName: "Signature.txt", mimeType: "" )
            }
        }, with: alamofireRequest)
        .onURLSessionTaskCreation { task in
            taskOut = task as? URLSessionDataTask
        }
        .uploadProgress { (progress) in
            uploadProgress?(progress)
        }
        .responseString(queue: requestQueue) { response in
            switch response.result {
            case let .success(value):
                if let data = value.data(using: .utf8) {
                    do {
                        let dict = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                        if let error = response.error {
                            completion(taskOut, dict, error as NSError)
                            break
                        }
                        if let code = response.response?.statusCode, code != 200 {
                            let userInfo: [String: Any] = [
                                NSLocalizedDescriptionKey: dict?["Error"] ?? "",
                                NSLocalizedFailureReasonErrorKey: dict?["ErrorDescription"] ?? ""
                            ]
                            let err = NSError.init(domain: "ProtonCore-Networking", code: code, userInfo: userInfo)
                            completion(taskOut, dict, err)
                            break
                        }
                        completion(taskOut, dict, nil)
                        break
                    } catch let error {
                        completion(taskOut, nil, error as NSError)
                        return
                    }
                }
                completion(taskOut, nil, nil)
            case let .failure(error):
                let err = error.underlyingError ?? (error as NSError)
                completion(taskOut, nil, err as NSError)
            }
        }
    }
    
    public func request(with request: SessionRequest,
                        completion: @escaping ResponseCompletion) {
        
        guard let alamofireRequest = request as? AlamofireRequest else {
            completion(nil, nil, nil)
            return
        }
        alamofireRequest.updateHeader()
        var taskOut: URLSessionDataTask?
        self.session.request(alamofireRequest)
            .onURLSessionTaskCreation { task in
                taskOut = task as? URLSessionDataTask
            }
            .uploadProgress { (progress) in
                
            }
            .responseString(queue: requestQueue) { response in
                switch response.result {
                case let .success(value):
                    if let data = value.data(using: .utf8) {
                        do {
                            let dict = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                            if let error = response.error {
                                completion(taskOut, dict, error as NSError)
                                break
                            }
                            if let code = response.response?.statusCode, code != 200 {
                                let userInfo: [String: Any] = [
                                    NSLocalizedDescriptionKey: dict?["Error"] ?? "",
                                    NSLocalizedFailureReasonErrorKey: dict?["ErrorDescription"] ?? ""
                                ]
                                let err = NSError.init(domain: "ProtonCore-Networking", code: code, userInfo: userInfo)
                                completion(taskOut, dict, err)
                                break
                            }
                            completion(taskOut, dict, nil)
                            break
                        } catch let error {
                            PMLog.debug("""
                                [ERROR] JSON serialization failed!
                                
                                Request url: \(response.request?.url?.absoluteString ?? "")
                                Request headers: \(response.request?.allHTTPHeaderFields ?? [:])
                                
                                Response status: \(response.response?.statusCode ?? -1)
                                Response headers: \(response.response?.allHeaderFields ?? [:])
                                Response body: \(response.data.flatMap { String(data: $0, encoding: .utf8) } ?? "")
                                """)
                            completion(taskOut, nil, error as NSError)
                            return
                        }
                    }
                    completion(taskOut, nil, nil)
                case let .failure(error):
                    let err = error.underlyingError ?? (error as NSError)
                    completion(taskOut, nil, err as NSError)
                }
            }
    }
    
    public func download(with request: SessionRequest,
                         destinationDirectoryURL: URL,
                         completion: @escaping DownloadCompletion) {
        guard let alamofireRequest = request as? AlamofireRequest else {
            completion(nil, nil, nil)
            return
        }
        alamofireRequest.updateHeader()
        var taskOut: URLSessionDataTask?
        let destination: Alamofire.DownloadRequest.Destination = { _, _ in
            return (destinationDirectoryURL, [.removePreviousFile, .createIntermediateDirectories])
        }
        self.session.download(alamofireRequest, to: destination)
            .onURLSessionTaskCreation { task in
                taskOut = task as? URLSessionDataTask
            }
            .uploadProgress { (progress) in
            }
            .response { response in
                switch response.result {
                case let .success(value):
                    completion(taskOut?.response, value, nil)
                case let .failure(error):
                    let err = error.underlyingError ?? (error as NSError)
                    completion(taskOut?.response, nil, err as NSError)
                }
            }
    }
    
    public func generate(with method: HTTPMethod2, urlString: String, parameters: Any? = nil, timeout: TimeInterval? = nil) -> SessionRequest {
        return AlamofireRequest.init(parameters: parameters, urlString: urlString, method: method, timeout: timeout ?? defaultTimeout)
    }
    
    public func failsTLS(request: SessionRequest) -> String? {
        if let request = request as? URLRequestConvertible, let url = try? request.asURLRequest().url,
           let index = tlsFailedRequests.firstIndex(where: { $0.url?.absoluteString == url.absoluteString }) {
            tlsFailedRequests.remove(at: index)
            return CoreString._net_insecure_connection_error
        }
        return nil
    }
    
    private func markAsFailedTLS(request: URLRequest) {
        tlsFailedRequests.append(request)
    }
}

class AlamofireRequest: SessionRequest, URLRequestConvertible {
    var parameterEncoding: ParameterEncoding {
        switch method {
        case .get:
            return URLEncoding.default
        default:
            return JSONEncoding.default
        }
    }
    
    override init(parameters: Any?, urlString: String, method: HTTPMethod, timeout: TimeInterval) {
        super.init(parameters: parameters, urlString: urlString, method: method, timeout: timeout)
        // TODO:: this url need to add a validation and throws
        let url = URL.init(string: urlString)!
        self.request = URLRequest(url: url)
        self.request?.timeoutInterval = timeout
        self.request?.httpMethod = self.method.toString()
    }
    
    func asURLRequest() throws -> URLRequest {
        return try parameterEncoding.encode(request!, with: parameters as? [String: Any])
    }
}

#endif

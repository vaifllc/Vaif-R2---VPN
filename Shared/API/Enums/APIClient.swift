//
//  APIClient.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 1/4/23.
//

import Foundation

enum HTTPMethod3: String {
    case get = "GET"
    case put = "PUT"
    case post = "POST"
    case delete = "DELETE"
    
    var description: String {
        return self.rawValue
    }
}

enum HTTPContentType: String {
    case applicationXWWWFromUrlencoded = "application/x-www-form-urlencoded"
    case applicationJSON = "application/json"
}

struct HTTPHeader2 {
    let field: String
    let value: String
}

class APIRequest {
    let method: HTTPMethod3
    let path: String
    var queryItems: [URLQueryItem]?
    var headers: [HTTPHeader2]?
    var body: Data?
    var contentType: HTTPContentType
    var addressType: AddressType?
    
    init(method: HTTPMethod3, path: String, contentType: HTTPContentType = .applicationJSON, addressType: AddressType? = nil) {
        self.method = method
        self.path = path
        self.contentType = contentType
        self.addressType = addressType
    }
}

struct APIResponse<Body> {
    let statusCode: Int
    let body: Body
}

extension APIResponse where Body == Data? {
    func decode<BodyType: Decodable>(to type: BodyType.Type) throws -> APIResponse<BodyType> {
        guard let data = body else {
            throw APIError.decodingFailure
        }
        let decodedJSON = try JSONDecoder().decode(BodyType.self, from: data)
        return APIResponse<BodyType>(statusCode: self.statusCode, body: decodedJSON)
    }
}

enum APIError: Error {
    case invalidURL
    case requestFailed
    case decodingFailure
}

enum APIResult<Body> {
    case success(APIResponse<Body>)
    case failure(APIError)
}

class APIClient: NSObject {
    
    // MARK: - Typealias -
    
    typealias APIClientCompletion = (APIResult<Data?>) -> Void
    
    // MARK: - Properties -
    
    private var hostName = UserDefaults.shared.apiHostName
    
    private var baseURL: URL {
        return URL(string: "https://\(hostName)")!
    }
    
    private var userAgent: String {
        if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
            return "ivpn/ios \(version)"
        }
        
        return "ivpn/ios"
    }
    
    var session: URLSession {
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = ["User-Agent": userAgent]
        configuration.urlCache = nil
        configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
        
        return URLSession(configuration: configuration, delegate: self, delegateQueue: nil)
    }
    
    // MARK: - Methods -
    
    func perform(_ request: APIRequest, nextHost: String? = nil, _ completion: @escaping APIClientCompletion) {
        if let addressType = request.addressType, nextHost == nil {
            switch addressType {
            case .IPv4:
                if let ipv4HostName = APIAccessManager.shared.ipv4HostName {
                    hostName = ipv4HostName
                } else {
                    completion(.failure(.requestFailed))
                    return
                }
            case .IPv6:
                if let ipv6HostName = APIAccessManager.shared.ipv6HostName {
                    hostName = ipv6HostName
                } else {
                    completion(.failure(.requestFailed))
                    return
                }
            default:
                break
            }
        }
        
        if let nextHost = nextHost {
            hostName = nextHost
        }
        
        var urlComponents = URLComponents()
        urlComponents.scheme = baseURL.scheme
        urlComponents.host = hostName
        urlComponents.path = baseURL.path
        urlComponents.queryItems = request.queryItems
        
        // TODO: Remove when fixed in future iOS versions
        // https://github.com/ivpn/ios-app/issues/276
        if #available(iOS 16.0, *), let addressType = request.addressType, addressType == .IPv6 {
            urlComponents.host = "[\(hostName)]"
        }
        
        if request.method == .post {
            urlComponents.queryItems = []
        }
        
        guard let url = urlComponents.url?.appendingPathComponent(request.path) else {
            completion(.failure(.invalidURL))
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.cachePolicy = .reloadIgnoringLocalCacheData
        
        if request.method == .post, let queryItems = request.queryItems, !queryItems.isEmpty {
            switch request.contentType {
            case .applicationXWWWFromUrlencoded:
                urlRequest.httpBody = query(queryItems).data(using: .utf8)
            case .applicationJSON:
                let parameters = queryItems.reduce([String: Any]()) { (dict, queryItem) -> [String: Any] in
                    var dict = dict
                    
                    switch queryItem.value {
                    case "true":
                        dict[queryItem.name] = true
                    case "false":
                        dict[queryItem.name] = false
                    default:
                        dict[queryItem.name] = queryItem.value
                    }
                    
                    return dict
                }
                
                do {
                    urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
                } catch let error {
                    print(error.localizedDescription)
                }
                
                urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
            }
        }
        
        request.headers?.forEach { urlRequest.addValue($0.value, forHTTPHeaderField: $0.field) }
        
        let task = session.dataTask(with: urlRequest) { data, response, _ in
            guard let httpResponse = response as? HTTPURLResponse else {
                if let nextHost = APIAccessManager.shared.nextHostName(failedHostName: self.hostName, addressType: request.addressType) {
                    self.retry(request, nextHost: nextHost, addressType: request.addressType) { result in
                        completion(result)
                    }
                    return
                }
                
                completion(.failure(.requestFailed))
                return
            }
            completion(.success(APIResponse<Data?>(statusCode: httpResponse.statusCode, body: data)))
        }
        task.resume()
    }
    
    func retry(_ request: APIRequest, nextHost: String, addressType: AddressType? = nil, _ completion: @escaping APIClientCompletion) {
        perform(request, nextHost: nextHost) { result in
            switch result {
            case .success:
                if addressType == nil {
                    UserDefaults.shared.set(nextHost, forKey: UserDefaults.Key.apiHostName)
                }
            case .failure:
                break
            }
            
            completion(result)
        }
    }
    
    func cancel() {
        session.invalidateAndCancel()
    }
    
    private func query(_ queryItems: [URLQueryItem]) -> String {
        var components: [(String, String)] = []
        for queryItem in queryItems {
            components += queryComponents(queryItem.name, queryItem.value ?? "")
        }
        
        return (components.map { "\($0)=\($1)" }).joined(separator: "&")
    }
    
    private func queryComponents(_ key: String, _ value: Any) -> [(String, String)] {
        var components: [(String, String)] = []
        if let dictionary = value as? [String: Any] {
            for (nestedKey, value) in dictionary {
                components += queryComponents("\(key)[\(nestedKey)]", value)
            }
        } else if let array = value as? [Any] {
            for value in array {
                components += queryComponents("\(key)", value)
            }
        } else {
            components.append((
                percentEncodeString(key),
                percentEncodeString("\(value)"))
            )
        }
        
        return components
    }
    
    private func percentEncodeString(_ originalObject: Any) -> String {
        if originalObject is NSNull {
            return "null"
        } else {
            var reserved = CharacterSet.urlQueryAllowed
            reserved.remove(charactersIn: ": #[]@!$&'()*+, ;=")
            return String(describing: originalObject)
                .addingPercentEncoding(withAllowedCharacters: reserved) ?? ""
        }
    }
    
}

// MARK: - URLSessionDelegate -

extension APIClient: URLSessionDelegate {
    
    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        guard let trust = challenge.protectionSpace.serverTrust, SecTrustGetCertificateCount(trust) > 0 else {
            completionHandler(.cancelAuthenticationChallenge, nil)
            return
        }
        
        // TLS host name validation
        guard validateHostName(of: challenge, tlsHostName: R2Config.TlsHostName) else {
            completionHandler(.cancelAuthenticationChallenge, nil)
            return
        }
        
        // Certificate public key validation
        let publicKeyPin = APIPublicKeyPin()
        if publicKeyPin.validate(serverTrust: trust, domain: nil) {
            completionHandler(.useCredential, URLCredential(trust: trust))
            return
        }
        
        completionHandler(.cancelAuthenticationChallenge, nil)
    }
    
    private func validateHostName(of challenge: URLAuthenticationChallenge, tlsHostName: String) -> Bool {
        guard challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust else {
            return false
        }
        
        guard let serverTrust = challenge.protectionSpace.serverTrust else {
            return false
        }
        
        guard let serverCert = SecTrustGetCertificateAtIndex(serverTrust, 0),
            let commonName = SecCertificateCopySubjectSummary(serverCert) as String? else {
                return false
        }
        
        guard commonName.contains(tlsHostName) else {
            return false
        }
        
        guard challenge.protectionSpace.host == hostName else {
            return false
        }
        
        return true
    }
    
}


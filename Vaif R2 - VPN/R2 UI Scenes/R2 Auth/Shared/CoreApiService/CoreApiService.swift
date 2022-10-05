//
//  CoreApiService.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 10/4/22.
//

import Foundation

public protocol CoreApiServiceFactory {
    func makeCoreApiService() -> CoreApiService
}

public protocol CoreApiService {
    func getApiNotifications(completion: @escaping (Result<GetApiNotificationsResponse, Error>) -> Void)
    func getApiFeature<T: Codable>(feature: CoreApiFeature, completion: @escaping (Result<T, Error>) -> Void)
}

public class CoreApiServiceImplementation: CoreApiService {
    private let networking: Networking
    
    public init(networking: Networking) {
        self.networking = networking
    }
    
    public func getApiNotifications(completion: @escaping (Result<GetApiNotificationsResponse, Error>) -> Void) {
        networking.request(CoreApiNotificationsRequest()) { (result: Result<JSONDictionary, Error>) in
            switch result {
            case let .success(json):
                do {
                    let data = try JSONSerialization.data(withJSONObject: json as Any, options: [])
                    let decoder = JSONDecoder()
                    // this strategy is decapitalizing first letter of response's labels to get appropriate name of the ServicePlanDetails object
                    decoder.keyDecodingStrategy = .decapitaliseFirstLetter
                    decoder.dateDecodingStrategy = .secondsSince1970
                    let result = try decoder.decode(GetApiNotificationsResponse.self, from: data)

                    completion(.success(result))
                } catch let error {
                    completion(.failure(error))
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }

    public func getApiFeature<T: Codable>(feature: CoreApiFeature, completion: @escaping (Result<T, Error>) -> Void) {
        networking.request(CoreApiFeatureRequest(feature: feature)) { (result: Result<CoreApiFeatureRespone<T>, Error>) in
            switch result {
            case let .success(data):
                completion(.success(data.feature.value))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}


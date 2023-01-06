//
//  ApiRequestDI.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 1/3/23.
//

import Foundation

struct ApiRequestDI {
    let method: HTTPMethod3
    let endpoint: String
    let params: [URLQueryItem]?
    let contentType: HTTPContentType
    let addressType: AddressType?
    
    init(method: HTTPMethod3, endpoint: String, params: [URLQueryItem]? = nil, contentType: HTTPContentType = .applicationJSON, addressType: AddressType? = nil) {
        self.method = method
        self.endpoint = endpoint
        self.params = params
        self.contentType = contentType
        self.addressType = addressType
    }
}


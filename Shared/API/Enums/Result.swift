//
//  Result.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 1/4/23.
//

import Foundation

enum R1Result<T: Decodable> {
    case success(T)
    case failure(Error?)
}

enum ResultCustomError<T: Decodable, E: Decodable> {
    case success(T)
    case failure(E?)
}

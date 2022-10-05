//
//  CoreApiFeatureRespone.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 10/4/22.
//

import Foundation


struct CoreApiFeatureRespone<T: Codable>: Codable {
    let code: Int
    let feature: Feature<T>
}

struct Feature<T: Codable>: Codable {
    let value: T
}

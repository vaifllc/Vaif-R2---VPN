//
//  ErrorResult.swift
//  VaifR2
//
//  Created by VAIF on 1/5/23.
//

import Foundation

struct ErrorResult: Decodable {
    let status: Int
    let message: String
}

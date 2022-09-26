//
//  Result+Extensions.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 9/26/22.
//

import Foundation

//extension Result where Success == Void {
//    public static var success: Self { .success(()) }
//}

extension Result {
    public func invoke(success: @escaping (Success) -> Void, failure: @escaping (Error) -> Void) {
        switch self {
        case let .success(data):
            success(data)
        case let .failure(error):
            failure(error)
        }
    }
}


//
//  Result+Extensions2.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 9/26/22.
//

import Foundation

public extension Swift.Result where Success == Void {
    static var success: Swift.Result<Success, Failure> {
        return .success(())
    }
}

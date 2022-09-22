//
//  Result+Extensions.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 9/21/22.
//

import Foundation


public extension Swift.Result where Success == Void {
    static var success: Swift.Result<Success, Failure> {
        return .success(())
    }
}


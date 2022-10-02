//
//  Threading.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 9/27/22.
//

import Foundation

public func executeOnUIThread(closure: @escaping () -> Void) {
    if Thread.isMainThread {
        closure()
    } else {
        DispatchQueue.main.async {
            closure()
        }
    }
}

public func dispatchAssert(condition: DispatchPredicate) {
    #if DEBUG
    dispatchPrecondition(condition: condition)
    #endif
}


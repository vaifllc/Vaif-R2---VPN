//
//  GlobalFunction.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 9/21/22.
//

import Foundation

func runInMainThread(closure: @escaping () -> Void) {
    if Thread.isMainThread {
        closure()
    } else {
        DispatchQueue.main.async {
            closure()
        }
    }
}


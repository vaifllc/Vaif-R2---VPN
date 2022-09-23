//
//  AsyncAwait.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 9/22/22.
//

import PromiseKit

func async<T>(_ body: @escaping () throws -> T) -> Promise<T> {
    Promise { seal in
        DispatchQueue.global().async {
            do {
                let value = try body()
                seal.fulfill(value)
            } catch {
                seal.reject(error)
            }
        }
    }
}

func async(_ body: @escaping () -> Void) {
    DispatchQueue.global().async {
        body()
    }
}

func await<T>(_ promise: Promise<T>) throws -> T {
    try AwaitKit.await(promise)
}

enum AwaitKit {
    static func await<T>(_ promise: Promise<T>) throws -> T {
        if Thread.isMainThread {
            assertionFailure("Should not call this method on main thread.")
        }

        return try promise.wait()
    }
}


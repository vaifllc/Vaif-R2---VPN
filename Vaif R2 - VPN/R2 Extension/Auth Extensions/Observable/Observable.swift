//
//  Observable.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 9/26/22.
//

import Foundation

final class Observable<T> {
    var value: T {
        didSet {
            executeOnMainThread {
                self.listener?(self.value)
            }
        }
    }

    private var listener: ((T) -> Void)?

    init(_ value: T) {
        self.value = value
    }

    func bind(_ closure: @escaping (T) -> Void) {
        executeOnMainThread {
            closure(self.value)
        }
        assert(listener == nil, "Binding already used")
        listener = closure
    }
}

final class Publisher<T> {
    func publish(_ value: T) {
        executeOnMainThread {
            self.listener?(value)
        }
    }

    private var listener: ((T) -> Void)?

    func bind(_ closure: @escaping (T) -> Void) {
        assert(listener == nil, "Binding already used")
        listener = closure
    }
}

func executeOnMainThread(closure: @escaping () -> Void) {
    if Thread.isMainThread {
        closure()
    } else {
        DispatchQueue.main.async {
            closure()
        }
    }
}


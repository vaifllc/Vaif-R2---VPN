//
//  Atomic.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 10/9/22.
//

import Foundation

public final class Atomic<A> {
    private let serialAccessQueue = DispatchQueue(label: "ch.proton.atomic_queue")
    private var internalValue: A
    public init(_ value: A) {
        self.internalValue = value
    }

    public var value: A { serialAccessQueue.sync { self.internalValue } }

    public func mutate(_ transform: (inout A) -> Void) {
        serialAccessQueue.sync {
            transform(&self.internalValue)
        }
    }
    
    public func transform<T>(_ transform: (A) -> T) -> T {
        serialAccessQueue.sync {
            transform(self.internalValue)
        }
    }
}

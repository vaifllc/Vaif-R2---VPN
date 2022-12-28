//
//  Stabbing+Ergonomics.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 10/9/22.
//

import Foundation

public protocol Stabbing {
    associatedtype Input
    associatedtype A1
    associatedtype A2
    associatedtype A3
    associatedtype A4
    associatedtype A5
    associatedtype A6
    associatedtype A7
    associatedtype A8
    associatedtype A9
    associatedtype A10
    associatedtype A11
    associatedtype A12
    var callCounter: UInt { get }
    var capturedArguments: [CapturedArguments<Input, A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12>] { get }
}

extension StubbedFunction: Stabbing {}
extension ThrowingStubbedFunction: Stabbing {}

extension Stabbing {

    public var wasNotCalled: Bool { callCounter == .zero }
    public var wasCalled: Bool { callCounter != .zero }

    public var wasCalledExactlyOnce: Bool { callCounter == 1 }

    public var lastArguments: CapturedArguments<Input, A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12>? { capturedArguments.last }

    public func arguments(forCallCounter: UInt) -> CapturedArguments<Input, A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12>? {
        let argumentsIndex = Int(forCallCounter) - 1
        return capturedArguments.indices.contains(argumentsIndex) ? capturedArguments[argumentsIndex] : nil
    }
}

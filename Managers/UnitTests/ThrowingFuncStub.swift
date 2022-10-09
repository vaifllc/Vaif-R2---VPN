//
//  ThrowingFuncStub.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 10/9/22.
//

import Foundation
import XCTest

@propertyWrapper
public final class ThrowingFuncStub<Input, Output, A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12> {

    public var wrappedValue: ThrowingStubbedFunction<Input, Output, A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12>

    init(initialReturn: @escaping (Input) throws -> Output, function: String, line: UInt, file: String) {
        wrappedValue = ThrowingStubbedFunction(initialReturn: .init(initialReturn), function: function, line: line, file: file)
    }

    init(initialReturn: InitialReturn<Input, Output>, function: String, line: UInt, file: String) {
        wrappedValue = ThrowingStubbedFunction(initialReturn: initialReturn, function: function, line: line, file: file)
    }

    init(function: String, line: UInt, file: String) where Output == Void {
        wrappedValue = ThrowingStubbedFunction(initialReturn: .init { _ in }, function: function, line: line, file: file)
    }
}

public final class ThrowingStubbedFunction<Input, Output, A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12> {

    public private(set) var callCounter: UInt = .zero
    public private(set) var capturedArguments: [CapturedArguments<Input, A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12>] = []

    public var description: String
    public var ensureWasCalled = false
    public var failOnBeingCalledUnexpectedly = false

    private lazy var implementation: (UInt, Input) throws -> Output = { [unowned self] _, input in
        guard let initialReturn = initialReturn else {
            XCTFail("initial return was not provided: \(self.description)")
            fatalError()
        }
        if self.failOnBeingCalledUnexpectedly {
            XCTFail("this method should not be called but was: \(self.description)")
            return try initialReturn.closure(input)
        }
        return try initialReturn.closure(input)
    }

    private var initialReturn: InitialReturn<Input, Output>?

    init(initialReturn: InitialReturn<Input, Output>, function: String, line: UInt, file: String) {
        self.initialReturn = initialReturn
        description = "\(function) at line \(line) of file \(file)"
    }

    func replaceBody(_ newImplementation: @escaping (UInt, Input) throws -> Output) {
        initialReturn = nil
        implementation = newImplementation
    }

    func appendBody(_ additionalImplementation: @escaping (UInt, Input) throws -> Output) {
        guard initialReturn == nil else {
            replaceBody(additionalImplementation)
            return
        }
        let currentImplementation = implementation
        implementation = {
            // ignoring the first output
            _ = try currentImplementation($0, $1)
            return try additionalImplementation($0, $1)
        }
    }

    func callAsFunction(input: Input, arguments: CapturedArguments<Input, A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12>) throws -> Output {
        callCounter += 1
        capturedArguments.append(arguments)
        return try implementation(callCounter, input)
    }

    deinit {
        if ensureWasCalled && callCounter == 0 {
            XCTFail("this method should be called but wasn't: \(description)")
        }
    }
}

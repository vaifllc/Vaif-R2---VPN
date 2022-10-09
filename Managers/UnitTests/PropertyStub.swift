//
//  PropertyStub.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 10/9/22.
//

import XCTest

@propertyWrapper
public final class PropertyStub<Property> {

    public var wrappedValue: StubbedProperty<Property>

    public init<T>(_ keyPath: KeyPath<T, Property>, initialGet: @autoclosure @escaping () -> Property) {
        wrappedValue = StubbedProperty(keyPath, initialGet)
    }

    public init<T>(_ keyPath: KeyPath<T, Property>, initialGet: InitialReturn<Void, Property>) {
        wrappedValue = StubbedProperty(keyPath, { try! initialGet.closure(()) })
    }
}

public final class StubbedProperty<Property> {

    // swiftlint:disable:next operator_usage_whitespace
    public typealias SetCapturedArguments = CapturedArguments<Property, Property, Absent, Absent, Absent, Absent, Absent,
                                                              Absent, Absent, Absent, Absent, Absent, Absent>

    @FuncStub(StubbedProperty<Property>.get, initialReturn: .crash) var getStub
    func `get`() -> Property { getStub() }

    @FuncStub(StubbedProperty<Property>.set) var setStub
    func `set`(newValue: Property) { setStub(newValue) }

    fileprivate init<T>(_ keyPath: KeyPath<T, Property>, _ defaultGet: @escaping () -> Property) {
        getStub.bodyIs { _ in defaultGet() }
    }

    public var getCallCounter: UInt { getStub.callCounter }
    public var setCallCounter: UInt { setStub.callCounter }

    public var getWasCalled: Bool { getCallCounter != .zero }
    public var setWasCalled: Bool { setCallCounter != .zero }

    public var getWasCalledExactlyOnce: Bool { getCallCounter == 1 }
    public var setWasCalledExactlyOnce: Bool { setCallCounter == 1 }

    public var setLastArguments: SetCapturedArguments? { setStub.lastArguments }
    public func setArguments(forCallCounter: UInt) -> SetCapturedArguments? {
        setStub.arguments(forCallCounter: forCallCounter)
    }

    public var fixture: Property {
        get { get() }
        set { getStub.bodyIs { _ in newValue } }
    }

    public func fix(_ get: @escaping (UInt) -> Property, set: @escaping (UInt, Property) -> Void = { _, _ in }) {
        getStub.bodyIs { get($0) }
        setStub.bodyIs { set($0, $1) }
    }

    public func callAsFunction() -> Property {
        get()
    }

    public func callAsFunction(_ newValue: Property) {
        set(newValue: newValue)
    }
}


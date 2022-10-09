//
//  InitialReturn.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 10/9/22.
//

import Foundation

public enum Absent: Int, Equatable, Codable { case nothing }

public struct InitialReturn<Input, Output> {
    let closure: (Input) throws -> Output

    init(_ closure: @escaping (Input) throws -> Output) {
        self.closure = closure
    }

    public static var crash: InitialReturn<Input, Output> {
        .init { _ in
            fatalError("Stub setup error — you must provide a default value of type \(Output.self) if this stub is ever called!")
        }
    }
}


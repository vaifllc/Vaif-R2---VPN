//
//  CompletionBlockExecutor.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 9/22/22.
//

public struct CompletionBlockExecutor {
    public init(executionContext: @escaping (@escaping () -> Void) -> Void) {
        self.executionContext = executionContext
    }
    
    public func execute(completionBlock: @escaping () -> Void) {
        executionContext(completionBlock)
    }
    
    private let executionContext: (@escaping () -> Void) -> Void
}

extension CompletionBlockExecutor {
    
    public static let asyncMainExecutor = asyncExecutor(dispatchQueue: .main)
    public static let immediateExecutor = CompletionBlockExecutor { $0() }
    
    public static func asyncExecutor(dispatchQueue: DispatchQueue) -> Self {
        .init { work in
            dispatchQueue.async(execute: work)
        }
    }

}


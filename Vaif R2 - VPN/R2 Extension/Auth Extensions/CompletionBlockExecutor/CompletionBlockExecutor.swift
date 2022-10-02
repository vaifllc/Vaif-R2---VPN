//
//  CompletionBlockExecutor.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 9/29/22.
//

import Foundation


public struct CompletionBlockExecutor {
    
    private let executionContext: (DispatchTimeInterval?, @escaping () -> Void) -> Void
    
    public init(executionContext: @escaping (DispatchTimeInterval?, @escaping () -> Void) -> Void) {
        self.executionContext = executionContext
    }
    
    public func execute(after: DispatchTimeInterval? = nil, completionBlock: @escaping () -> Void) {
        executionContext(after, completionBlock)
    }
}

extension CompletionBlockExecutor {
    
    public static let asyncMainExecutor = asyncExecutor(dispatchQueue: .main)
    public static let immediateExecutor = CompletionBlockExecutor { $1() } // immediate executor ignores all delays
    
    public static func asyncExecutor(dispatchQueue: DispatchQueue) -> Self {
        .init { after, work in
            if let after = after {
                dispatchQueue.asyncAfter(deadline: DispatchTime.now() + after, execute: work)
            } else {
                dispatchQueue.async(execute: work)
            }
        }
    }
}

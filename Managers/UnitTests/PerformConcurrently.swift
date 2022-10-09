//
//  PerformConcurrently.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 10/9/22.
//

@available(iOS 13.0, macOS 10.15, *)
public func performConcurrentlySettingExpectations<T>(
    amount: UInt = 20, _ work: @escaping (UInt, CheckedContinuation<T, Never>) -> Void
) async -> [T] {
    await withTaskGroup(of: T.self) { group -> [T] in
        for index in 1...amount {
            group.addTask {
                await withCheckedContinuation { continuation in
                    work(index, continuation)
                }
            }
        }
        var results = [T]()
        for await element in group {
            results.append(element)
        }
        return results
    }
}


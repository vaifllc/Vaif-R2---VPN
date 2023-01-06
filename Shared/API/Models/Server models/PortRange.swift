//
//  PortRange.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 1/2/23.
//

import Foundation

struct PortRange {
    
    // MARK: - Properties -
    
    var tunnelType: String
    var protocolType: String
    var ranges: [CountableClosedRange<Int>]
    
    var portRangesText: String {
        let combinedRanges = PortRange.combinedIntervals(intervals: ranges.sorted { $0.lowerBound < $1.lowerBound })
        var textRanges = [String]()
        
        for range in combinedRanges {
            textRanges.append("\(String(describing: range.first ?? 0)) - \(String(describing: range.last ?? 0))")
        }
        
        return textRanges.joined(separator: ", ")
    }
    
    // MARK: - Methods -
    
    func validate(port: Int) -> String? {
        for range in ranges {
            if range.contains(port) {
                return nil
            }
        }
        
        return "Enter port number in the range: \(portRangesText)"
    }
    
    static func combinedIntervals(intervals: [CountableClosedRange<Int>]) -> [CountableClosedRange<Int>] {
        var combined = [CountableClosedRange<Int>]()
        var accumulator = (0...0) // empty range
        
        for interval in intervals.sorted(by: { $0.lowerBound  < $1.lowerBound  } ) {
            
            if accumulator == (0...0) {
                accumulator = interval
            }
            
            if accumulator.upperBound >= interval.upperBound {
                // interval is already inside accumulator
            }
                
            else if accumulator.upperBound + 1 >= interval.lowerBound  {
                // interval hangs off the back end of accumulator
                accumulator = (accumulator.lowerBound...interval.upperBound)
            }
                
            else if accumulator.upperBound <= interval.lowerBound  {
                // interval does not overlap
                combined.append(accumulator)
                accumulator = interval
            }
        }
        
        if accumulator != (0...0) {
            combined.append(accumulator)
        }
        
        return combined
    }
    
}


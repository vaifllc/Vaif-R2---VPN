//
//  NSObject+Extension.swift
//  VaifR2
//
//  Created by VAIF on 1/12/23.
//

import Foundation
extension NSObject {
    public func track(_ message: Any, file: String = #file, function: String = #function, line: Int = #line ) {
        guard let fileName = file.components(separatedBy: "/").last else {return}
        if message is [String: Any] {
            print("FILE: \(fileName), FUNCTION: \(function):\(line) DATA: \(message as! [String: Any])  ")
        }
        if message is String {
            print("FILE: \(fileName), FUNCTION: \(function):\(line) DATA: \(message as! String) ")
        }
    }
}

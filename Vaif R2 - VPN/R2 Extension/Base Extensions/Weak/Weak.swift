//
//  Weak.swift
//  VaifR2
//
//  Created by VAIF on 1/7/23.
//

import Foundation

public class Weak<T: AnyObject> {
    
    public weak var value: T?
    
    public init(value: T) {
        self.value = value
    }
}

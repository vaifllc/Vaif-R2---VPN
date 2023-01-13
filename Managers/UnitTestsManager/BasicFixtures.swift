//
//  BasicFixtures.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 10/9/22.
//

import Foundation

public enum Dummy {
    public static let domain = "protoncore.unittest"
    public static let url = "https://\(domain)"
    public static let apiPath = "/unittest/api"
}

public extension String {
    static var empty: String { "" }
}

public extension Array {
    func filter2(_ isIncluded: (Element) throws -> Bool) rethrows -> ([Element], [Element]) {
        var yes = [Element]()
        var no = [Element]()
        for elem in self {
            if try isIncluded(elem) {
                yes.append(elem)
            } else {
                no.append(elem)
            }
        }
        return (yes, no)
    }
    static var empty: Array { [] }
}

extension Array where Element: Equatable {
    
    func next(item: Element) -> Element? {
        if let index = self.firstIndex(of: item), index + 1 <= self.count {
            return index + 1 == self.count ? nil : self[index + 1]
        }
        return nil
    }
    
    mutating func move(_ item: Element, to newIndex: Index) {
        if let index = firstIndex(of: item) {
            move(at: index, to: newIndex)
        }
    }
    
    mutating func move(at index: Index, to newIndex: Index) {
        insert(remove(at: index), at: newIndex)
    }
    
    public subscript(safeIndex index: Int) -> Element? {
        guard index >= 0, index < endIndex else {
            return nil
        }
        
        return self[index]
    }
    
}

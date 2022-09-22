//
//  AccessibleCell.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 9/21/22.
//

import Foundation
import UIKit

private let maxDeepness = 2
private var cellIdentifiers = Set<String>()

/**
 Assigns accessibility identifiers to the Cell and cell class members that belong to UIView, UIButton and UITextField types using reflection.
 */
public protocol AccessibleCell {
    func generateCellAccessibilityIdentifiers(_ uniqueIdentifier: String)
}

public extension AccessibleCell {
    
    func generateCellAccessibilityIdentifiers(_ uniqueIdentifier: String) {
        #if DEBUG
        let mirror = Mirror(reflecting: self)
        assignIdentifiers(mirror, uniqueIdentifier, 0)
        #endif
    }
    
    #if DEBUG
    private func assignIdentifiers(_ mirror: Mirror, _ originalUniqueIdentifier: String, _ deepnessLevel: Int) {
        
        if deepnessLevel > maxDeepness { return }
        
        let cell = self as? UIView
        let uniqueIdentifier = originalUniqueIdentifier.replacingOccurrences(of: " ", with: "_")
        
        cell?.accessibilityIdentifier = "\(type(of: self)).\(uniqueIdentifier)"
        cellIdentifiers.insert((cell?.accessibilityIdentifier)!)
        
        for child in mirror.children {
            if let view = child.value as? UIView {
                let identifier = child.label?.replacingOccurrences(of: ".storage", with: "")
                let viewMirror = Mirror(reflecting: view)
                
                if viewMirror.children.count > 0 {
                   assignIdentifiers(viewMirror, uniqueIdentifier, deepnessLevel + 1)
                }
                
                view.accessibilityIdentifier = "\(uniqueIdentifier).\(identifier!)"
                cellIdentifiers.insert((cell?.accessibilityIdentifier)!)
           } else if let view = child.value as? UIButton,
                let identifier = child.label?.replacingOccurrences(of: ".storage", with: "") {
                let viewMirror = Mirror(reflecting: view)
            
                if viewMirror.children.count > 0 {
                    assignIdentifiers(viewMirror, uniqueIdentifier, deepnessLevel + 1)
                }
            
                view.accessibilityIdentifier = "\(uniqueIdentifier).\(identifier)"
                cellIdentifiers.insert(view.accessibilityIdentifier!)
           } else if let view = child.value as? UITextField,
                let identifier = child.label?.replacingOccurrences(of: ".storage", with: "") {
                let viewMirror = Mirror(reflecting: view)
            
                if viewMirror.children.count > 0 {
                   assignIdentifiers(viewMirror, uniqueIdentifier, deepnessLevel + 1)
                }
            
                view.accessibilityIdentifier = "\(uniqueIdentifier).\(identifier)"
                cellIdentifiers.insert(view.accessibilityIdentifier!)
           }
        }
    }
    #endif
}



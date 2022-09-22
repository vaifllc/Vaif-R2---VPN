//
//  UITableView+Reusable.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 9/21/22.
//

import UIKit
// MARK: - UITableView Extensions
extension UITableView {
    final func  register<T: UITableViewHeaderFooterView & Reusable>(cellType: T.Type) {
        register(cellType.self, forHeaderFooterViewReuseIdentifier: cellType.reuseIdentifier)
    }
}

extension UITableView {
    final func dequeueReusableCell<T: UITableViewHeaderFooterView & Reusable>() -> T {
        guard let cell = dequeueReusableHeaderFooterView(withIdentifier: T.reuseIdentifier) as? T else {
            fatalError("Failed to dequeue reusable cell with identifier '\(T.reuseIdentifier)'.")
        }
        return cell
    }
}


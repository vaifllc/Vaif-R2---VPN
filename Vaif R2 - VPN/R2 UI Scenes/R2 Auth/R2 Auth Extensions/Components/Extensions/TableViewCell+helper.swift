//
//  TableViewCell+helper.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 9/21/22.
//

import UIKit
public protocol LineSeparatable {
    func addSeparator(padding: CGFloat) -> UIView
    func addSeparator(leftRef: UIView, constant: CGFloat) -> UIView
}

public extension LineSeparatable where Self: UIView {
    /// Add separator at bottom of view cell
    @discardableResult
    func addSeparator(padding: CGFloat = 16) -> UIView {
        let line = UIView()
        addSubview(line)
        line.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            line.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            line.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            line.bottomAnchor.constraint(equalTo: bottomAnchor),
            line.heightAnchor.constraint(equalToConstant: 1)
        ])
        line.backgroundColor = ColorProvider.SeparatorNorm
        return line
    }

    /// Add separator at bottom of view cell
    @discardableResult
    func addSeparator(leftRef: UIView, constant: CGFloat) -> UIView {
        let line = UIView()
        addSubview(line)
        line.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            line.leadingAnchor.constraint(equalTo: leftRef.leadingAnchor, constant: constant),
            line.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            line.bottomAnchor.constraint(equalTo: bottomAnchor),
            line.heightAnchor.constraint(equalToConstant: 1)
        ])
        line.backgroundColor = ColorProvider.SeparatorNorm
        return line
    }
}

extension UITableViewCell: LineSeparatable {}


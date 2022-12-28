//
//  UIImage+Extensions.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 9/26/22.
//

import Foundation
import UIKit

public extension UIImage {
    
    func with(alpha: CGFloat = 1.0) -> UIImage {
        let format = UIGraphicsImageRendererFormat()
        format.opaque = false
        return UIGraphicsImageRenderer(size: self.size, format: format).image { context in
            draw(in: context.format.bounds, blendMode: .normal, alpha: alpha)
        }
    }

    static func colored(with color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { context in
            color.setFill()
            context.fill(CGRect(origin: .zero, size: size))
        }
    }

    @available(*, deprecated, renamed: "IconProvider.crossClose")
    static var closeImage: UIImage? {
        IconProvider.crossSmall
    }

    @available(*, deprecated, renamed: "IconProvider.arrowLeft")
    static var backImage: UIImage? {
        IconProvider.arrowLeft
    }
    
    func imageWithInsets(insets: UIEdgeInsets) -> UIImage? {
        let targetSize = CGSize(width: self.size.width + insets.left + insets.right,
                                height: self.size.height + insets.top + insets.bottom)
        let targetOrigin = CGPoint(x: insets.left, y: insets.top)

        let format = UIGraphicsImageRendererFormat()
        format.scale = scale
        let renderer = UIGraphicsImageRenderer(size: targetSize, format: format)
        return renderer.image { _ in
            self.draw(in: CGRect(origin: targetOrigin, size: size))
        }.withRenderingMode(renderingMode)
    }
}

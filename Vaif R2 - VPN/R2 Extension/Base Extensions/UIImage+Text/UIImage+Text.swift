//
//  UIImage+Text.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 9/26/22.
//

import Foundation
import UIKit

extension UIImage {
    static func textEmbeded(image: UIImage, string: String, font: UIFont) -> UIImage {
        let expectedTextSize = (string as NSString).size(withAttributes: [.font: font])
        let width = expectedTextSize.width + image.size.width + 5
        let height = max(expectedTextSize.height, image.size.width)
        let size = CGSize(width: width, height: height)

        let renderer = UIGraphicsImageRenderer(size: size)
        return renderer.image { _ in
            let fontTopPosition: CGFloat = (height - expectedTextSize.height) / 2
            let textOrigin: CGFloat = image.size.width + 5
            let textPoint: CGPoint = CGPoint(x: textOrigin, y: fontTopPosition)
            string.draw(at: textPoint, withAttributes: [.font: font])
            let rect = CGRect(x: 0,
                              y: (height - image.size.height) / 2,
                          width: image.size.width,
                         height: image.size.height)
            image.draw(in: rect)
        }
    }
}

//
//  ImageAlias.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 9/28/22.
//

import Foundation
#if canImport(UIKit)
import UIKit
public typealias Image = UIImage
#elseif canImport(AppKit)
import AppKit
public typealias Image = NSImage
#endif

//
//  EmptyLogContent.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 9/30/22.
//

import Foundation

/// Empty content used when any content should be provided instead of the unsupported one.
/// For example, OSLogContent is available only on ios 15+, so on ios 14 and older `EmptyLogContent` can be returned instead.
class EmptyLogContent: LogContent {

    func loadContent(callback: @escaping (String) -> Void) {
        callback("")
    }
    
}


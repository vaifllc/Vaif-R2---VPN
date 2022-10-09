//
//  LogHandler+Metadata.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 10/9/22.
//


import Logging

extension LogHandler {
    func convert(metadata: Logging.Logger.Metadata?) -> [String: String] {
        let fullMetadata = (metadata != nil) ? self.metadata.merging(metadata!, uniquingKeysWith: { _, new in new }) : self.metadata
        return fullMetadata.reduce(into: [String: String](), { result, element in
            result[element.key] = element.value.description
        })
    }
}


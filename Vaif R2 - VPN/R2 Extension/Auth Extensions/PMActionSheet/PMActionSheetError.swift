//
//  PMActionSheetError.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 9/26/22.
//

import Foundation


enum PMActionSheetError: Error, LocalizedError {
    case itemGroupMissing
    case unknowItem
    case initializeFailed
    case styleError

    var localizedDescription: String {
        switch self {
        case .itemGroupMissing:
            return "Item group is missing"
        case .unknowItem:
            return "Can't get item by given indexPath"
        case .initializeFailed:
            return "At least one of needed parameters missing"
        case .styleError:
            return "Must be Grid style"
        }
    }
}

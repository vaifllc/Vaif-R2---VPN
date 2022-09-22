//
//  Address+Extensions.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 9/22/22.
//

import Foundation

extension Array where Element: Address {
    
    /// find the default address.  status is enable and receive is active
    /// - Returns: address | nil
    public func defaultAddress() -> Address? {
        for addr in self {
            if addr.status == .enabled && addr.receive == .active {
                return addr
            }
        }
        return nil
    }
    
    /// find the default send address. status is enable, receive is acitve, send is active
    /// - Returns: address | nil
    public func defaultSendAddress() -> Address? {
        for addr in self {
            if addr.status == .enabled && addr.receive == .active && addr.send == .active {
                return addr
            }
        }
        return nil
    }
    
    /// lookup the first active address
    /// - Parameter addressID: address id
    /// - Returns: address | nil
    public func address(byID addressID: String) -> Address? {
        for addr in self {
            if addr.status == .enabled && addr.receive == .active && addr.addressID == addressID {
                return addr
            }
        }
        return nil
    }
    
    @available(*, deprecated, renamed: "address(byID:)")
    public func indexOfAddress(_ addressid: String) -> Address? {
        for addr in self {
            if addr.status == .enabled && addr.receive == .active && addr.addressID == addressid {
                return addr
            }
        }
        return nil
    }
    
    public func getAddressOrder() -> [String] {
        let ids = self.map { $0.addressID }
        return ids
    }
    
    /// forgot what is this and when will use this
    /// - Returns: description
    func getAddressNewOrder() -> [Int] {
        let ids = self.map { $0.order }
        return ids
    }
    
    /// collect all keys in all addresses
    /// - Returns: [Key]
    public func toKeys() -> [Key] {
        var out_array = [Key]()
        for i in 0 ..< self.count {
            let addr = self[i]
            for k in addr.keys {
                out_array.append(k)
            }
        }
        return out_array
    }
}


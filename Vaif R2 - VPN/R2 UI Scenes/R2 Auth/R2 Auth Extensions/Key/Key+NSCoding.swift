//
//  Key+NSCoding.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 9/22/22.
//

import Foundation
import UIKit

// This NSCoding is used for archive the object to data then encrypt it before save to keychain.
//   will need to redesign to save this to core data
extension Key: NSCoding {
    private struct CoderKey {
        static let keyID          = "keyID"
        static let privateKey     = "privateKey"
        
        //
        static let flags = "Key.Flags"
        
        //
        static let token     = "Key.Token"
        static let signature = "Key.Signature"
        
        //
        static let activation = "Key.Activation"
        
        //
        static let primary = "Key.Primary"
        static let active = "Key.Active"
        static let version = "Key.Version"
    }
    
    static func unarchive(_ data: Data?) -> [Key]? {
        guard let data = data else { return nil }
        return NSKeyedUnarchiver.unarchiveObject(with: data) as? [Key]
    }
    
    public convenience init(coder aDecoder: NSCoder) {
        
        let keyID = aDecoder.string(forKey: CoderKey.keyID)
        let privateKey = aDecoder.string(forKey: CoderKey.privateKey)
        
        let flags = aDecoder.decodeInteger(forKey: CoderKey.flags)
        
        let token = aDecoder.string(forKey: CoderKey.token)
        let signature = aDecoder.string(forKey: CoderKey.signature)
        
        let activation = aDecoder.string(forKey: CoderKey.activation)
        
        let active = aDecoder.decodeInteger(forKey: CoderKey.active)
        let version = aDecoder.decodeInteger(forKey: CoderKey.version)
        
        let primary = aDecoder.decodeInteger(forKey: CoderKey.primary)
        
        self.init(keyID: keyID ?? "", privateKey: privateKey,
                  keyFlags: flags,
                  token: token, signature: signature, activation: activation,
                  active: active,
                  version: version,
                  primary: primary)
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(self.keyID, forKey: CoderKey.keyID)
        aCoder.encode(self.privateKey, forKey: CoderKey.privateKey)
        
        aCoder.encode(self.keyFlags, forKey: CoderKey.flags)
        
        aCoder.encode(self.token, forKey: CoderKey.token)
        aCoder.encode(self.signature, forKey: CoderKey.signature)
        
        aCoder.encode(self.activation, forKey: CoderKey.activation)
        
        aCoder.encode(self.active, forKey: CoderKey.active)
        aCoder.encode(self.version, forKey: CoderKey.version)
        
        aCoder.encode(self.primary, forKey: CoderKey.primary)
    }
}


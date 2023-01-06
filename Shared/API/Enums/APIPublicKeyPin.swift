//
//  APIPublicKeyPin.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 1/4/23.
//

import Foundation
import CryptoKit
import CommonCrypto

class APIPublicKeyPin {
    
    // MARK: - Properties -
    
    private let hashes = [
        "g6WEFnt9DyTi70nW/fufsZNw83vFpcmIhMuDPQ1MFcI=",
        "KCcpK9y22OrlapwO1/oP8q3LrcDM9Jy9lcfngg2r+Pk=",
        "iRHkSbdOY/YD8EE5fpl8W0P8EqmfkBRTADEegR2/Wnc=",
        "47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU="
    ]
    
    // MARK: - Methods -
    
    public func validate(serverTrust: SecTrust, domain: String?) -> Bool {
        if let domain = domain {
            let policies = NSMutableArray()
            policies.add(SecPolicyCreateSSL(true, domain as CFString))
            SecTrustSetPolicies(serverTrust, policies)
        }
        
        var secResult = SecTrustResultType.invalid
        let status = SecTrustEvaluate(serverTrust, &secResult)
        
        guard status == errSecSuccess else {
            return false
        }
        
        for index in 0..<SecTrustGetCertificateCount(serverTrust) {
            guard let certificate = SecTrustGetCertificateAtIndex(serverTrust, index),
                  let publicKey = SecCertificateCopyKey(certificate),
                  let publicKeyData = SecKeyCopyExternalRepresentation(publicKey, nil) else {
                return false
            }
            
            let keyHash = hash(data: (publicKeyData as NSData) as Data)
            if hashes.contains(keyHash) {
                return true
            }
        }
        
        return false
    }
    
    private func hash(data: Data) -> String {
        // Add the missing ASN1 header for public keys to re-create the subject public key info
        let rsa4096Asn1Header: [UInt8] = [
            0x30, 0x82, 0x02, 0x22, 0x30, 0x0d, 0x06, 0x09, 0x2a, 0x86, 0x48, 0x86,
            0xf7, 0x0d, 0x01, 0x01, 0x01, 0x05, 0x00, 0x03, 0x82, 0x02, 0x0f, 0x00
        ]
        var keyWithHeader = Data(rsa4096Asn1Header)
        keyWithHeader.append(data)
        
        if #available(iOS 13, *) {
            return Data(SHA256.hash(data: keyWithHeader)).base64EncodedString()
        } else {
            return sha256(keyWithHeader)?.base64EncodedString() ?? ""
        }
    }
    
    private func sha256(_ data: Data) -> Data? {
        guard let res = NSMutableData(length: Int(CC_SHA256_DIGEST_LENGTH)) else {
            return nil
        }
        
        CC_SHA256((data as NSData).bytes, CC_LONG(data.count), res.mutableBytes.assumingMemoryBound(to: UInt8.self))
        
        return res as Data
    }
    
}


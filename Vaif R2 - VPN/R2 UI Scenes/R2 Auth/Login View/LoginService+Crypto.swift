//
//  LoginService+Crypto.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 9/26/22.
//

#if canImport(Crypto_VPN)
import Crypto_VPN
#elseif canImport(Crypto)
import Crypto
#endif
import Foundation

extension LoginService {
    // Code take from Drive
    // TODO:: need to deperate this function. go lib has low performance than the other file we have
    func makePassphrases(salts: [KeySalt], mailboxPassword: String) -> Result<[String: String], Error> {
        var error: NSError?

        let passphrases = salts.filter {
            $0.keySalt != nil
        }.map { salt -> (String, String) in
            let keySalt = salt.keySalt!
            
            let passSlic = mailboxPassword.data(using: .utf8)

            let saltPackage = Data(base64Encoded: keySalt, options: NSData.Base64DecodingOptions(rawValue: 0))
            let passphraseSlic = SrpMailboxPassword(passSlic, saltPackage, &error)
            
            let passphraseUncut = String.init(data: passphraseSlic!, encoding: .utf8)
            // by some internal reason of go-srp, output will be 60 characters but we need only last 31 of them
            let passphrase = passphraseUncut!.suffix(31)
            
            return (salt.ID, String(passphrase))
        }

        if let error = error {
            return .failure(error)
        }

        return .success(Dictionary(passphrases, uniquingKeysWith: { one, _ in one }))
    }

    func validateMailboxPassword(passphrases: ([String: String]), userKeys: [Key]) -> Bool {
        var isValid = false
  
        // new keys - user keys
        passphrases.forEach { keyID, passphrase in
            userKeys.filter { $0.keyID == keyID && $0.primary == 1 }
            .map(\.privateKey)
            .forEach { privateKey in
                var error: NSError?
                let armored = CryptoNewKeyFromArmored(privateKey, &error)

                do {
                    try armored?.unlock(passphrase.utf8)
                    isValid = true
                } catch {
                    // do nothing
                }
            }
        }

        return isValid
    }
}

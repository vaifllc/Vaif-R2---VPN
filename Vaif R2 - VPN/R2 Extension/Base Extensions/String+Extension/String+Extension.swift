//
//  String+Extension.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 10/2/22.
//

import Foundation

public extension String {
    
    
    func commaSeparatedToArray() -> [String] {
        return components(separatedBy: .whitespaces)
            .joined()
            .split(separator: ",")
            .map(String.init)
    }
    func base64KeyToHex() -> String? {
        let base64 = self
        
        guard base64.count == 44 else {
            return nil
        }
        
        guard base64.last == "=" else {
            return nil
        }
        
        guard let keyData = Data(base64Encoded: base64) else {
            return nil
        }
        
        guard keyData.count == 32 else {
            return nil
        }
        
        let hexKey = keyData.reduce("") {$0 + String(format: "%02x", $1)}
        
        return hexKey
    }
    func deletingPrefix(_ prefix: String) -> String {
        guard self.hasPrefix(prefix) else {
            return self
        }
        
        return String(self.dropFirst(prefix.count))
    }
    
    func deletingSuffix(_ suffix: String) -> String {
        guard self.hasSuffix(suffix) else {
            return self
        }
        
        return String(self.dropLast(suffix.count))
    }
    
    func updateAttribute(key: String, value: String) -> String {
        var array = [String]()
        for setting in self.components(separatedBy: "\n") {
            if setting.hasPrefix(key) {
                array.append("\(key)=\(value)")
            } else {
                array.append(setting)
            }
        }
        return array.joined(separator: "\n")
    }
    
    func initials() -> String {
        let invalids = "[.,/#!$@%^&*;:{}=\\-_`~()]"
        let splits = self
            .components(separatedBy: .whitespaces)
            .compactMap { $0.first?.uppercased() }
            .filter { !invalids.contains($0) }

        var initials = [splits.first]
        if splits.count > 1 {
            initials.append(splits.last)
        }

        let result = initials
            .compactMap { $0 }
            .joined()
        return result.isEmpty ? "?": result
    }
    
    func contains(_ string: String) -> Bool {
        return self.range(of: string, options: NSString.CompareOptions.caseInsensitive) != nil ? true : false
    }
    
    func matches(for regex: String) -> [String] {
        do {
            let regex = try NSRegularExpression(pattern: regex)
            let nsString = self as NSString
            let results = regex.matches(in: self, range: NSRange(location: 0, length: nsString.length))
            return results.map { nsString.substring(with: $0.range) }
        } catch let error {
            //log.error("Invalid regex", category: .app, metadata: ["error": "\(error)"])
            return []
        }
    }
    
    func hasMatches(for regex: String) -> Bool {
        return !matches(for: regex).isEmpty
    }
    
    func preg_replace_none_regex(_ partten: String, replaceto: String) -> String {
        return self.replacingOccurrences(of: partten, with: replaceto, options: NSString.CompareOptions.caseInsensitive, range: nil)
    }
    
    func preg_replace(_ partten: String, replaceto: String) -> String {
        let options: NSRegularExpression.Options = [.caseInsensitive, .dotMatchesLineSeparators]
        do {
            let regex = try NSRegularExpression(pattern: partten, options: options)
            let replacedString = regex.stringByReplacingMatches(in: self, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSRange(location: 0, length: self.count), withTemplate: replaceto)
            if !replacedString.isEmpty {
                return replacedString
            }
        } catch let error as NSError {
            print("Invalid regex \(error)")
            //log.error("Invalid regex", category: .app, metadata: ["error": "\(error)"])
        }
        return self
    }
    
    static func randomString(length: Int) -> String {
        let allowedChars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let allowedCharsCount = UInt32(allowedChars.count)
        var randomString = ""
        
        for _ in 0..<length {
            let randomNum = Int(arc4random_uniform(allowedCharsCount))
            let randomIndex = allowedChars.index(allowedChars.startIndex, offsetBy: randomNum)
            let newCharacter = allowedChars[randomIndex]
            randomString += String(newCharacter)
        }
        
        return randomString
    }
    
    func encodeBase64() -> String {
        let utf8str = self.data(using: String.Encoding.utf8)
        let base64Encoded = utf8str!.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
        return base64Encoded
    }
    
    func decodeBase64() -> String {
        let decodedData = Data(base64Encoded: self, options: NSData.Base64DecodingOptions(rawValue: 0))
        let decodedString = NSString(data: decodedData!, encoding: String.Encoding.utf8.rawValue)
        return decodedString! as String
    }
    
    func decodeBase64() -> Data {
        let decodedData = Data(base64Encoded: self, options: NSData.Base64DecodingOptions(rawValue: 0))
        return decodedData!
    }
}

public extension String {
    
    subscript (i: Int) -> Character {
        return self[index(startIndex, offsetBy: i)]
    }
    
    subscript (i: Int) -> String {
        return String(self[i] as Character)
    }
    
    subscript (r: Range<Int>) -> String {
        let start = index(startIndex, offsetBy: r.lowerBound)
        let end = index(startIndex, offsetBy: r.upperBound)
        let range: Range<Index> = start..<end
        return String(self[range])
    }
}

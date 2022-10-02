//
//  Storage.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 9/28/22.
//

import Foundation

public class Storage {
    
    private static let migrationKey = "migratedTo"
    
    private static let standardDefaults = UserDefaults.standard
    private static var specifiedDefaults: UserDefaults?
    
    public static func setSpecificDefaults(defaults: UserDefaults) {
        if !defaults.bool(forKey: Storage.migrationKey) {
            // Move any compatible data from old defaults to the new one
            Storage.standardDefaults.dictionaryRepresentation().forEach { (key, value) in
                defaults.set(value, forKey: key)
            }
            
            defaults.setValue(true, forKey: Storage.migrationKey)
            defaults.synchronize()
        }
        
        Storage.specifiedDefaults = defaults
    }
    
    public static func userDefaults() -> UserDefaults {
        if let specifiedDefaults = specifiedDefaults {
            return specifiedDefaults
        } else {
            return Storage.standardDefaults
        }
    }

    public init() { }
    
    public var defaults: UserDefaults {
        return Self.userDefaults()
    }
    
    public func setValue(_ value: Any?, forKey key: String) {
        defaults.setValue(value, forKey: key)
        log.info("Setting was changed", category: .settings, event: .change, metadata: ["key": "\(key)", "value": "\(value.stringForLog)"])
    }

    public func getValue(forKey key: String) -> Any? {
        defaults.value(forKey: key)
    }
    
    public func setEncodableValue<Value>(_ value: Value?, forKey key: String) where Value: Encodable {
        defaults.setValue(value != nil ? try? JSONEncoder().encode(value) : nil, forKey: key)
    }
    
    public func getDecodableValue<T>(_ type: T.Type, forKey key: String) -> T? where T: Decodable {
        guard let data = defaults.data(forKey: key) else {
            return nil
        }
        
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            log.warning("Can't decode value from JSON", category: .settings, metadata: ["error": "\(error)"])
        }
        // Backup for data saved in older app versions (ios: <=2.7.1, macos: <=2.2.2)
        do {
            return try PropertyListDecoder().decode(T.self, from: data)
        } catch {
            log.warning("Can't decode value from PropertyList", category: .settings, metadata: ["error": "\(error)"])
        }
        return nil
    }
    
    public func contains(_ key: String) -> Bool {
        return defaults.object(forKey: key) != nil
    }
    
    public func removeObject(forKey key: String) {
        defaults.removeObject(forKey: key)
    }
}

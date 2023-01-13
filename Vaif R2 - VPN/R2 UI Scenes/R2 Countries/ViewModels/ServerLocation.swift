//
//  ServerLocation.swift
//  VaifR2
//
//  Created by VAIF on 1/8/23.
//

import Foundation

public class ServerLocation: NSObject, NSCoding {
    
    public let lat: Double
    public let long: Double
    
    override public var description: String {
        return
            "Lat: \(lat)\n" +
            "Long: \(long)\n"
    }
    
    public init(lat: Double, long: Double) {
        self.lat = lat
        self.long = long
        super.init()
    }
    
    public init(dic: JSONDictionary) throws {
        lat = try dic.doubleOrThrow(key: "Lat")
        long = try dic.doubleOrThrow(key: "Long")
        super.init()
    }

    /// Used for testing purposes.
    var asDict: [String: Any] {
        [
            "Lat": lat,
            "Long": long,
        ]
    }
    
    // MARK: - NSCoding
    private struct CoderKey {
        static let lat = "latKey"
        static let long = "longKey"
    }
    
    public required convenience init?(coder aDecoder: NSCoder) {
        self.init(lat: aDecoder.decodeDouble(forKey: CoderKey.lat),
                  long: aDecoder.decodeDouble(forKey: CoderKey.long))
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(lat, forKey: CoderKey.lat)
        aCoder.encode(long, forKey: CoderKey.long)
    }
}


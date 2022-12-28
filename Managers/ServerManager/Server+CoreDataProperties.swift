//
//  Server+CoreDataProperties.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 12/27/22.
//

import Foundation
import CoreData

extension R1Server {
    
    @NSManaged public var gateway: String?
    @NSManaged public var isFastestEnabled: Bool
    
    @nonobjc public class func fetchRequest(gateway: String = "", isFastestEnabled: Bool = false) -> NSFetchRequest<R1Server> {
        let fetchRequest = NSFetchRequest<R1Server>(entityName: "Server")
        var filters = [NSPredicate]()
        
        if !gateway.isEmpty {
            filters.append(NSPredicate(format: "gateway == %@", gateway.replacingOccurrences(of: ".wg.", with: ".gw.")))
        }
        
        if isFastestEnabled {
            filters.append(NSPredicate(format: "isFastestEnabled == %@", NSNumber(value: isFastestEnabled)))
        }
        
        fetchRequest.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: filters)
        
        return fetchRequest
    }

}


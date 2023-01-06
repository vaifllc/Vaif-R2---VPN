//
//  CustomPort+CoreDataProperties.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 1/3/23.
//

import Foundation
import CoreData

extension CustomPort {
    
    @NSManaged public var vpnProtocol: String?
    @NSManaged public var type: String?
    @NSManaged public var port: Int32

    @nonobjc public class func fetchRequest(vpnProtocol: String = "") -> NSFetchRequest<CustomPort> {
        let fetchRequest = NSFetchRequest<CustomPort>(entityName: "CustomPort")
        var filters = [NSPredicate]()
        
        if !vpnProtocol.isEmpty {
            filters.append(NSPredicate(format: "vpnProtocol == %@", vpnProtocol))
        }
        
        fetchRequest.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: filters)
        
        return fetchRequest
    }

}


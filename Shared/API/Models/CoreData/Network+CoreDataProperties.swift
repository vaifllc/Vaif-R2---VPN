//
//  Network+CoreDataProperties.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 1/3/23.
//

import Foundation
import CoreData

extension Network {

    @NSManaged public var isDefault: Bool
    @NSManaged public var name: String?
    @NSManaged public var trust: String?
    @NSManaged public var type: String?
    
    convenience init(context: NSManagedObjectContext, needToSave: Bool) {
        let entity = NSEntityDescription.entity(forEntityName: "Network", in: context)
        self.init(entity: entity!, insertInto: needToSave ? context : nil)
    }
    
    @nonobjc public class func fetchRequest(name: String = "", type: String = "", isDefault: Bool = false) -> NSFetchRequest<Network> {
        let fetchRequest = NSFetchRequest<Network>(entityName: "Network")
        var filters = [NSPredicate]()
        
        if !name.isEmpty {
            filters.append(NSPredicate(format: "name == %@", name))
        }
        
        if !type.isEmpty {
            filters.append(NSPredicate(format: "type == %@", type))
        }
        
        if isDefault {
            filters.append(NSPredicate(format: "isDefault == %@", NSNumber(value: isDefault)))
        }
        
        fetchRequest.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: filters)
        
        return fetchRequest
    }

}


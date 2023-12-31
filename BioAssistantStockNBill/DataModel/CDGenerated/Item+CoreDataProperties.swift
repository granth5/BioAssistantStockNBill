//
//  Item+CoreDataProperties.swift
//  BioAssistantStockNBill
//
//  Created by Grant on 12/15/23.
//
//

import Foundation
import CoreData


extension Item {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Item> {
        return NSFetchRequest<Item>(entityName: "Item")
    }

    @NSManaged public var itemDescription: String?
    @NSManaged public var itemId: Int32
    @NSManaged public var lCode: String?

}

extension Item : Identifiable {

}

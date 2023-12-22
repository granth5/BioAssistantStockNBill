//
//  Order+CoreDataProperties.swift
//  BioAssistantStockNBill
//
//  Created by Grant on 12/15/23.
//
//

import Foundation
import CoreData


extension Order {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Order> {
        return NSFetchRequest<Order>(entityName: "Order")
    }

    @NSManaged public var orderDate: Date?
    @NSManaged public var orderId: Int32
    @NSManaged public var patientId: Int32

}

extension Order : Identifiable {

}

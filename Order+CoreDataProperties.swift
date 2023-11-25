//
//  Order+CoreDataProperties.swift
//  BioAssistantStockNBill
//
//  Created by Grant on 11/24/23.
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
    @NSManaged public var orderItems: NSSet?
    @NSManaged public var patient: Patient?

}

// MARK: Generated accessors for orderItems
extension Order {

    @objc(addOrderItemsObject:)
    @NSManaged public func addToOrderItems(_ value: OrderItem)

    @objc(removeOrderItemsObject:)
    @NSManaged public func removeFromOrderItems(_ value: OrderItem)

    @objc(addOrderItems:)
    @NSManaged public func addToOrderItems(_ values: NSSet)

    @objc(removeOrderItems:)
    @NSManaged public func removeFromOrderItems(_ values: NSSet)

}

extension Order : Identifiable {

}

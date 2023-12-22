//
//  OrderItem+CoreDataProperties.swift
//  BioAssistantStockNBill
//
//  Created by Grant on 12/15/23.
//
//

import Foundation
import CoreData


extension OrderItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<OrderItem> {
        return NSFetchRequest<OrderItem>(entityName: "OrderItem")
    }

    @NSManaged public var itemId: Int32
    @NSManaged public var orderId: Int32
    @NSManaged public var orderItemId: Int32
    @NSManaged public var quantity: Int32

}

extension OrderItem : Identifiable {

}

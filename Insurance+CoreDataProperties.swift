//
//  Insurance+CoreDataProperties.swift
//  BioAssistantStockNBill
//
//  Created by Grant on 11/24/23.
//
//

import Foundation
import CoreData


extension Insurance {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Insurance> {
        return NSFetchRequest<Insurance>(entityName: "Insurance")
    }

    @NSManaged public var diagnosis: String?
    @NSManaged public var insuranceId: Int32
    @NSManaged public var insuranceName: String?
    @NSManaged public var insuranceType: String?
    @NSManaged public var orderId: Int32
    @NSManaged public var patientId: Int32
    @NSManaged public var policyGroup: String?
    @NSManaged public var policyId: String?
    @NSManaged public var patient: Patient?

}

extension Insurance : Identifiable {

}

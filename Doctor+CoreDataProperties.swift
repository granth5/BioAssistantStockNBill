//
//  Doctor+CoreDataProperties.swift
//  BioAssistantStockNBill
//
//  Created by Grant on 11/24/23.
//
//

import Foundation
import CoreData


extension Doctor {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Doctor> {
        return NSFetchRequest<Doctor>(entityName: "Doctor")
    }

    @NSManaged public var address1: String?
    @NSManaged public var address2: String?
    @NSManaged public var city: String?
    @NSManaged public var doctorId: Int32
    @NSManaged public var name: String?
    @NSManaged public var npiNumber: String?
    @NSManaged public var phone: String?
    @NSManaged public var state: String?
    @NSManaged public var zip: String?
    @NSManaged public var patient: Patient?

}

extension Doctor : Identifiable {

}

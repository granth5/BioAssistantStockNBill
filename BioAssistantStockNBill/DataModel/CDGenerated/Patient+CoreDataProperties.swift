//
//  Patient+CoreDataProperties.swift
//  BioAssistantStockNBill
//
//  Created by Grant on 12/15/23.
//
//

import Foundation
import CoreData


extension Patient {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Patient> {
        return NSFetchRequest<Patient>(entityName: "Patient")
    }

    @NSManaged public var address1: String?
    @NSManaged public var address2: String?
    @NSManaged public var city: String?
    @NSManaged public var dateOfBirth: Date?
    @NSManaged public var firstName: String?
    @NSManaged public var gender: String?
    @NSManaged public var lastName: String?
    @NSManaged public var patientId: Int32
    @NSManaged public var phone: String?
    @NSManaged public var state: String?
    @NSManaged public var zip: String?
    @NSManaged public var doctorId: Int32
    @NSManaged public var insuranceId1: Int32
    @NSManaged public var insuranceId2: Int32

}

extension Patient : Identifiable {

}

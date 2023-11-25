//
//  Patient+CoreDataProperties.swift
//  BioAssistantStockNBill
//
//  Created by Grant on 11/24/23.
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
    @NSManaged public var doctor: Doctor?
    @NSManaged public var insurances: NSSet?
    @NSManaged public var orders: NSSet?

}

// MARK: Generated accessors for insurances
extension Patient {

    @objc(addInsurancesObject:)
    @NSManaged public func addToInsurances(_ value: Insurance)

    @objc(removeInsurancesObject:)
    @NSManaged public func removeFromInsurances(_ value: Insurance)

    @objc(addInsurances:)
    @NSManaged public func addToInsurances(_ values: NSSet)

    @objc(removeInsurances:)
    @NSManaged public func removeFromInsurances(_ values: NSSet)

}

// MARK: Generated accessors for orders
extension Patient {

    @objc(addOrdersObject:)
    @NSManaged public func addToOrders(_ value: Order)

    @objc(removeOrdersObject:)
    @NSManaged public func removeFromOrders(_ value: Order)

    @objc(addOrders:)
    @NSManaged public func addToOrders(_ values: NSSet)

    @objc(removeOrders:)
    @NSManaged public func removeFromOrders(_ values: NSSet)

}

extension Patient : Identifiable {

}

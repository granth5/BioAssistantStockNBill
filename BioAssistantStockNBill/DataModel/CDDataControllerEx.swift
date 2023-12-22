//
//  CDDataControllerEx.swift
//  BioAssistantStockNBill
//
//  Created by Grant on 12/8/23.
//

import Foundation
import CoreData
import SwiftUI

extension CDDataController {
    func deleteAll() {
        let ctx = self.container.viewContext
        
        // Doctor
        let fetchReqDoc: NSFetchRequest<NSFetchRequestResult> = Doctor.fetchRequest()
        let batchDelReqDoc = NSBatchDeleteRequest(fetchRequest: fetchReqDoc)
        try? ctx.execute(batchDelReqDoc)
        save(context: ctx)
        
        // Item
        let fetchReqItem: NSFetchRequest<NSFetchRequestResult> = Item.fetchRequest()
        let batchDelReqItem = NSBatchDeleteRequest(fetchRequest: fetchReqItem)
        try? ctx.execute(batchDelReqItem)
        save(context: ctx)
        
        // Insurance
        let fetchReqIns: NSFetchRequest<NSFetchRequestResult> = Insurance.fetchRequest()
        let batchDelReqIns = NSBatchDeleteRequest(fetchRequest: fetchReqIns)
        try? ctx.execute(batchDelReqIns)
        save(context: ctx)
        
        // Patients
        let fetchReq: NSFetchRequest<NSFetchRequestResult> = Patient.fetchRequest()
        let batchDeleteReq = NSBatchDeleteRequest(fetchRequest: fetchReq)
        try? ctx.execute(batchDeleteReq)
        save(context: ctx)
        
        // OrderItem
        let fetchReqOrderItem: NSFetchRequest<NSFetchRequestResult> = OrderItem.fetchRequest()
        let batchDelReqOrderItem = NSBatchDeleteRequest(fetchRequest: fetchReqOrderItem)
        try? ctx.execute(batchDelReqOrderItem)
        save(context: ctx)
        
        // Order
        let fetchReqOrder: NSFetchRequest<NSFetchRequestResult> = Order.fetchRequest()
        let batchDelReqOrder = NSBatchDeleteRequest(fetchRequest: fetchReqOrder)
        try? ctx.execute(batchDelReqOrder)
        save(context: ctx)
        
        self.cdDataLoaded = false
    }
    
    
    //
    // ** loadDataFromCd()
    //
    func loadDataFromCd() {
        do {
            let cdOrders:[Order] = try fetch(entity: "Order")

            for order in cdOrders {
                let newOrder = OrderJ(orderId: order.orderId, patientId: order.patientId, orderDate: order.orderDate!)
               
                self.orders.append(newOrder)
            }

        } catch {
            print("Error: ", error.localizedDescription)
        }
        
        do {
            let cdOrderItems:[OrderItem] = try fetch(entity: "OrderItem")

            for orderItem in cdOrderItems {
                let newOrderItem = OrderItemJ(
                    itemId: orderItem.orderId,
                    orderId: orderItem.orderId,
                    orderItemId: orderItem.orderItemId,
                    quantity: orderItem.quantity)

                    self.orderItems.append(newOrderItem)
            }

        } catch {
            print("Error: ", error.localizedDescription)
        }

        do {
            let cdItems:[Item] = try fetch(entity: "Item")
            
            for item in cdItems {
                let newItem = ItemJ(
                    itemId: item.itemId,
                    itemDescription: item.itemDescription!,
                    lCode: item.lCode!
                )
                
                self.items.append(newItem)
            }
        } catch {
            print("Error: ", error.localizedDescription)
        }

        do {
            let cdDoctors:[Doctor] = try fetch(entity: "Doctor")
            
            for doc in cdDoctors {
                let newDoc = DoctorJ(
                    doctorId: doc.doctorId,
                    name: doc.name!,
                    address1: doc.address1!,
                    address2: doc.address2!,
                    city: doc.city!,
                    state: doc.state!,
                    zip: doc.zip!,
                    phone: doc.phone!,
                    npiNumber: doc.npiNumber!
                )
                
                self.doctors.append(newDoc)
            }
        } catch {
            print("Error: ", error.localizedDescription)
        }

        
        do {
            let cdInsurances:[Insurance] = try fetch(entity: "Insurance")
            
            for ins in cdInsurances {
                let newIns = InsuranceJ(
                    insuranceId: ins.insuranceId,
                    insuranceName: ins.insuranceName!,
                    insuranceType: ins.insuranceType!,
                    policyId: ins.policyId!,
                    policyGroupId: ins.policyGroup!,
                    diagnosis: ins.diagnosis!
                )
                
                self.insurances.append(newIns)
            }
        } catch {
            print("Error: ", error.localizedDescription)
        }

        do {
            let cdPatients:[Patient] = try fetch(entity: "Patient")
            
            for pat in cdPatients {
                let newPat = PatientJ(
                    patientId: pat.patientId,
                    lastName: pat.lastName!,
                    firstName: pat.firstName!,
                    address1: pat.address1!,
                    address2: pat.address2!,
                    city: pat.city!,
                    state: pat.state!,
                    zip: pat.zip!,
                    phone: pat.phone!,
                    gender: pat.gender!,
                    dateOfBirth: pat.dateOfBirth!,
                    doctorId: pat.doctorId,
                    insuranceId1: pat.insuranceId1,
                    insuranceId2: pat.insuranceId2
                )
                
                self.patients.append(newPat)
            }
        } catch {
            print("Error: ", error.localizedDescription)
        }



    }

    
    //
    // ** loadCdDataFromJson()
    //
    func loadCdDataFromJson() {
        
        // To do this and maintain CoreData relatioships, we need to honor all
        //  required objects w/in other objects - e.g., we can't simply insert
        //  an order with a patient ID and a patient with same ID later - CoreData
        //  has no clue about the link.
        //
        // What we do instead is maintain the object parent/child relationships
        //  by creating all child objects w/in the parent before saving the parent.
        //
        // Need to do this for ALL relationships:
        //  - Order
        //      - Patient
        //          - Doctor(s?)
        //          - Insurance(s?)
        //      - OrderItem
        //          - Item
        //
        // ** 12/8/23 - NOPE! - Going back to simple, independent tables and
        //  loading data manually into arrays
        
        let ctx = self.container.viewContext

        // Item
        for item in jsonHelper.items {
            let cdItem = NSEntityDescription.insertNewObject(forEntityName: "Item", into: ctx) as! Item
            
            cdItem.itemId = Int32(item.itemId)
            cdItem.itemDescription = item.itemDescription
            cdItem.lCode = item.lCode
            
            //save(context: ctx)
        }
        
        // Patient
        for pat in jsonHelper.patients {
            let cdPatient = NSEntityDescription.insertNewObject(forEntityName: "Patient", into: ctx) as! Patient
            
            cdPatient.patientId = Int32(pat.patientId)
            cdPatient.lastName = pat.lastName
            cdPatient.firstName = pat.firstName
            cdPatient.address1 = pat.address1
            cdPatient.address2 = pat.address2
            cdPatient.city = pat.city
            cdPatient.state = pat.state
            cdPatient.zip = pat.zip
            cdPatient.phone = pat.phone
            cdPatient.dateOfBirth = pat.dateOfBirth
            cdPatient.gender = pat.gender
            cdPatient.doctorId = pat.doctorId
            cdPatient.insuranceId1 = pat.insuranceId1
            cdPatient.insuranceId2 = pat.insuranceId2
        }

        // Doctor
        for doc in jsonHelper.doctors {
            let cdDoc = NSEntityDescription.insertNewObject(forEntityName: "Doctor", into: ctx) as! Doctor
            
            cdDoc.doctorId = Int32(doc.doctorId)
            cdDoc.name = doc.name
            cdDoc.address1 = doc.address1
            cdDoc.address2 = doc.address2
            cdDoc.city = doc.city
            cdDoc.state = doc.state
            cdDoc.zip = doc.zip
            cdDoc.phone = doc.phone
            cdDoc.npiNumber = doc.npiNumber
        }
            
        // Insurance
        for ins in jsonHelper.insurances {
            let cdIns = NSEntityDescription.insertNewObject(forEntityName: "Insurance", into: ctx) as! Insurance
            
            cdIns.insuranceId = Int32(ins.insuranceId)
            cdIns.insuranceName = ins.insuranceName
            cdIns.insuranceType = ins.insuranceType
            cdIns.policyId = ins.policyId
            cdIns.policyGroup = ins.policyGroupId
            cdIns.diagnosis = ins.diagnosis
        }
            
        // OrderItem
        for orderItem in jsonHelper.orderItems {
            let cdOrderItem = NSEntityDescription.insertNewObject(forEntityName: "OrderItem", into: ctx) as! OrderItem
            
            cdOrderItem.orderItemId = Int32(orderItem.orderItemId)
            cdOrderItem.orderId = Int32(orderItem.orderId)
            cdOrderItem.itemId = Int32(orderItem.itemId)
            cdOrderItem.quantity = Int32(orderItem.quantity)
            
            //save(context: ctx)
        }

        // Order
        for order in jsonHelper.orders {
            let cdOrder = NSEntityDescription.insertNewObject(forEntityName: "Order", into: ctx) as! Order
            
            cdOrder.orderId = Int32(order.orderId)
            cdOrder.orderDate =  order.orderDate
            cdOrder.patientId = Int32(order.patientId)
        }

        save(context: ctx)
        
        self.cdDataLoaded = true
    }
    

}

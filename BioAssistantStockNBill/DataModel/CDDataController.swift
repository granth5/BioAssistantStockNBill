//
//  CDDataController.swift
//  BioAssistantStockNBill
//
//  Created by Grant on 11/10/23.
//

// GHH - NOTE: updated w/various state indicators

import Foundation
import CoreData
import SwiftUI

class CDDataController: ObservableObject {
    @Published var jsonHelper: JsonDataHelper
    
    let container = NSPersistentContainer(name: "BioAssistDataModel")
    
    public var cdDataLoaded: Bool = false

    
    
    init() {
        
        self.jsonHelper = JsonDataHelper()
        
        container.loadPersistentStores { desc, error in
            if let error = error {
                print("Failed to load \(error.localizedDescription)")
            }
            
            // create new background context
            let ctx = self.container.newBackgroundContext()
            
            // if needed, ensure background ctx stays up
            //  to date with changes from parent
            ctx.automaticallyMergesChangesFromParent = true;

            do {
                // create fetch req
                //let fetchReq: NSFetchRequest<Patient>
                let fetchReq: NSFetchRequest<Insurance>

                //fetchReq = Patient.fetchRequest()
                fetchReq = Insurance.fetchRequest()
                fetchReq.fetchLimit = 1

                let objects = try ctx.fetch(fetchReq)

                // if we got here, no problems
                self.cdDataLoaded = !objects.isEmpty

            }
            catch let error {
                print("Error: " + error.localizedDescription)
            }
        }
    }
    
    func deleteAll() {
        let ctx = self.container.newBackgroundContext()
        
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
    
    func loadCdDataFromJson() {
        let ctx = self.container.newBackgroundContext()
        
        // Insurance
        for ins in jsonHelper.insurances {
            let cdIns = NSEntityDescription.insertNewObject(forEntityName: "Insurance", into: ctx) as! Insurance
            
            cdIns.insuranceId = Int32(ins.insuranceId)
            cdIns.insuranceName = ins.insuranceName
            cdIns.insuranceType = ins.insuranceType
            cdIns.orderId = Int32(ins.orderId)
            
            cdIns.patientId = Int32(ins.patientId)
            cdIns.policyId = ins.policyId
            cdIns.policyGroup = ins.policyGroupId
            cdIns.diagnosis = ins.diagnosis
            
            save(context: ctx)
        }
        
        // Doctor
        for doc in jsonHelper.doctors {
            let cdDoc = NSEntityDescription.insertNewObject(forEntityName: "Doctor", into: ctx) as! Doctor
            
            cdDoc.doctorId = Int32(doc.doctorId)
            cdDoc.name = doc.lastName + ", " + doc.firstName
            cdDoc.address1 = doc.address1
            cdDoc.address2 = doc.address2
            cdDoc.city = doc.city
            cdDoc.state = doc.state
            cdDoc.zip = doc.zip
            cdDoc.npiNumber = doc.npiNumber
            
            save(context: ctx)
        }
        


        // Item
        for item in jsonHelper.items {
            let cdItem = NSEntityDescription.insertNewObject(forEntityName: "Item", into: ctx) as! Item
            
            cdItem.itemId = Int32(item.itemId)
            cdItem.itemDescription = item.itemDescription
            cdItem.lCode = item.lCode
            
            save(context: ctx)
        }
        
        // Order
        for order in jsonHelper.orders {
            let cdOrder = NSEntityDescription.insertNewObject(forEntityName: "Order", into: ctx) as! Order
            
            cdOrder.orderId = Int32(order.orderId)
            cdOrder.orderDate =  order.orderDate
            cdOrder.patientId = Int32(order.patientId)
            
            // find and add patient
            if let pat = jsonHelper.patients.first(where: {$0.patientId == order.patientId}) {

                // Patient
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
                
                cdOrder.patient = cdPatient

            } else {
                print("Patient Save Error")
            }

            save(context: ctx)        }
        
        // OrderItem
        for orderItem in jsonHelper.orderItems {
            let cdOrderItem = NSEntityDescription.insertNewObject(forEntityName: "OrderItem", into: ctx) as! OrderItem
            
            cdOrderItem.orderItemId = Int32(orderItem.orderItemId)
            cdOrderItem.orderId = Int32(orderItem.orderId)
            cdOrderItem.itemId = Int32(orderItem.itemId)
            cdOrderItem.quantity = Int32(orderItem.quantity)
            
            save(context: ctx)
        }
        
        
        self.cdDataLoaded = true
    }
    
    func  test() {
        var ghh1 = jsonHelper.patients.count
        var ghh2 = 0
    }
    
    func save(context: NSManagedObjectContext) {
        do {
            try context.save()
            print("Data Saved")
        } catch {
            print("Error in save(\(error)")
        }
    }
    
    
   
}

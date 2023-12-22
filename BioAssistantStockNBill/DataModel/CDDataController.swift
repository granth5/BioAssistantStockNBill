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
    
    // singleton
    static let shared = CDDataController()
    
    @Published var orders = [OrderJ]()
    @Published var orderItems = [OrderItemJ]()
    @Published var items = [ItemJ]()
    @Published var patients = [PatientJ]()
    @Published var insurances = [InsuranceJ]()
    @Published var doctors = [DoctorJ]()
    
    let container = NSPersistentContainer(name: "BioAssistDataModel")
    
    public var cdDataLoaded: Bool = false
    public var storeLocation: String = ""

    init() {
        
        self.jsonHelper = JsonDataHelper()
        
        container.loadPersistentStores { desc, error in
            if let error = error {
                print("Failed to load \(error.localizedDescription)")
            }
            
            self.storeLocation = self.container.persistentStoreCoordinator.persistentStores.first?.url?.path ?? "NOT FOUND"
            print("STORE FILE LOC: \(self.storeLocation)")
            
            do {
                let fetchReq: NSFetchRequest<Order>

                fetchReq = Order.fetchRequest()
                fetchReq.fetchLimit = 1

                //let objects = try ctx.fetch(fetchReq)
                let objects = try self.container.viewContext.fetch(fetchReq)

                // if we got here, no problems
                self.cdDataLoaded = !objects.isEmpty

            }
            catch let error {
                print("Error: " + error.localizedDescription)
            }
        }
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
    
    func fetch<T:NSFetchRequestResult>(entity: String) throws -> [T] {
        let request = NSFetchRequest<T>(entityName: entity)
        let entities = try self.container.viewContext.fetch(request)
        return entities
    }
   
    func getOrderList() -> [OrderListOrderJ] {
        var retVal = [OrderListOrderJ]()
        
        
        
        for order in self.orders {
            var newListItem = OrderListOrderJ()
            newListItem.orderId = order.orderId
            newListItem.orderDate = order.orderDate
            
            let orderPatient: PatientJ = self.getPatientJ(patientId: order.patientId)
            newListItem.lastName = orderPatient.lastName
            newListItem.firstName = orderPatient.firstName
            
            let orderIns: InsuranceJ = self.getInsuranceJ(insuranceId: orderPatient.insuranceId1)
            newListItem.insuranceType = orderIns.insuranceType
            newListItem.insuranceName = orderIns.insuranceName
            
            retVal.append(newListItem)
        }
        
        return retVal
    }
    
    func getOrderEditInfo(orderId: Int32) -> OrderEditInfo {
        var retVal = OrderEditInfo(orderInfo: OrderJ(),
                                   patientInfo: OrderPatientInfo(
                                                    patient: PatientJ(),
                                                    doctor: DoctorJ(),
                                                    insurance1: InsuranceJ(),
                                                    insurance2: InsuranceJ()),
                                   orderItems: [OrderItemInfo]())
        if orderId > 0 {
            let orderInfoJ = self.getOrderJ(orderId: orderId)
            retVal.orderInfo = orderInfoJ
            
            retVal.patientInfo = self.getOrderEditPatientInfo(patientId: orderInfoJ.patientId)
            
            retVal.orderItems = self.getOrderEditItems(orderId: orderInfoJ.orderId)

        }
        
        return retVal
    }
    
    func getOrderEditItems(orderId: Int32) -> [OrderItemInfo] {
        var retVal = [OrderItemInfo]()
        
        for orderItem in self.orderItems {
            if orderItem.orderId == orderId {
                var item = self.getItemJ(itemId: orderItem.itemId)
                var newOrderItem = OrderItemInfo(
                                            orderItemId: Int32(orderItem.orderItemId),
                                            itemName: item.itemDescription,
                                            lCode: item.lCode,
                                            quantity: Int32(orderItem.quantity))
                
                retVal.append(newOrderItem)
            }
        }

        return retVal
    }
    
    func getOrderEditPatientInfo(patientId: Int32) -> OrderPatientInfo {
        var retVal = OrderPatientInfo(
                        patient: PatientJ(),
                        doctor: DoctorJ(),
                        insurance1: InsuranceJ(),
                        insurance2: InsuranceJ())
        
        let patInfo = self.getPatientJ(patientId: patientId)
        retVal.patient = patInfo
        
        retVal.insurance1 = self.getInsuranceJ(insuranceId: patInfo.insuranceId1)
        retVal.doctor = self.getDoctorJ(doctorId: patInfo.doctorId)
        
        return retVal
    }
    
   
    func getOrderJ(orderId: Int32) -> OrderJ {
        var retVal: OrderJ = OrderJ()
        
        if let ord = self.orders.first(where: {$0.orderId == orderId}) {
            retVal = ord
        }

        return retVal
    }
    
    func getPatientJ(patientId: Int32) -> PatientJ {
        var retVal: PatientJ = PatientJ()
        
        if let pat = self.patients.first(where: {$0.patientId == patientId}) {
            retVal = pat
        }
        
        return retVal
    }
    
    func getInsuranceJ(insuranceId: Int32) -> InsuranceJ {
        var retVal: InsuranceJ = InsuranceJ()
        
        if let ins = self.insurances.first(where: {$0.insuranceId == insuranceId}) {
            retVal = ins
        }
        
        return retVal
    }
    
    func getItemJ(itemId: Int32) -> ItemJ {
        var retVal: ItemJ = ItemJ()
        
        if let itm = self.items.first(where: {$0.itemId == itemId}) {
            retVal = itm
        }
        
        return retVal
    }
    
    func getDoctorJ(doctorId: Int32) -> DoctorJ {
        var retVal: DoctorJ = DoctorJ()
        
        if let doc = self.doctors.first(where: {$0.doctorId == doctorId}) {
            retVal = doc
        }
        
        return retVal
    }
    
}

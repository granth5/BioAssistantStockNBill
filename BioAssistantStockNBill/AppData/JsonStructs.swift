


//
//  JsonStructs.swift
//  BioAssistantStockNBill
//
//  Created by Grant on 11/10/23.
//

import Foundation

// struct for indiv. order
struct OrderEditInfo {
    var id = UUID()
    var orderInfo: OrderJ = OrderJ()
    var patientInfo: OrderPatientInfo = OrderPatientInfo()
    var orderItems: [OrderItemInfo] = [OrderItemInfo]()
}

struct OrderItemInfo {
    var orderItemId: Int32 = 0  // used for sort
    var itemName: String = ""
    var lCode: String = ""
    var quantity: Int32 = 0
}

struct OrderPatientInfo {
    var patient: PatientJ = PatientJ()
    var doctor: DoctorJ = DoctorJ()
    var insurance1: InsuranceJ = InsuranceJ()
    var insurance2: InsuranceJ = InsuranceJ()
}

// structs for raw/POC stuff
struct OrderListOrderJ: Codable, Identifiable {

    enum CodingKeys: CodingKey {
        case orderId
        case orderDate
        case lastName
        case firstName
        case insuranceType
        case insuranceName
    }
    
    var id = UUID()
    var orderId: Int32
    var orderDate: Date
    var lastName: String
    var firstName: String
    var insuranceType: String
    var insuranceName: String
    
    init(
        orderId: Int32 = 0,
        orderDate: Date = Date(),
        lastName: String = "",
        firstName: String = "",
        insuranceType: String = "",
        insuranceName: String = ""
    ) {
        self.orderId = orderId
        self.orderDate = orderDate
        self.lastName = lastName
        self.firstName = firstName
        self.insuranceType = insuranceType
        self.insuranceName = insuranceName
    }
}


struct OrderJ: Codable, Identifiable {
    var id = UUID()
    
    enum CodingKeys: String, CodingKey {
        case orderId,
            orderDate,
            patientId
    }
    
    var orderId: Int32
    var orderDate: Date
    var patientId: Int32
    
    init(orderId: Int32 = 0, patientId: Int32 = 0, orderDate: Date = Date()) {
        self.orderId = orderId
        self.patientId = patientId
        self.orderDate = orderDate
    }
}

struct OrderItemJ: Codable, Identifiable {
    var id = UUID()
    
    enum CodingKeys: String, CodingKey {
        case itemId,
            orderId,
            orderItemId,
            quantity
    }
    
    var itemId: Int32
    var orderId: Int32
    var orderItemId: Int32
    var quantity: Int32
    
    init (
        itemId: Int32 = 0,
        orderId: Int32 = 0,
        orderItemId: Int32 = 0,
        quantity: Int32 = 0
    ) {
        self.itemId = itemId
        self.orderId = orderId
        self.orderItemId = orderItemId
        self.quantity = quantity
    }
}

struct ItemJ: Codable, Identifiable {
    var id = UUID()
    
    enum CodingKeys: String, CodingKey {
        case itemId,
             itemDescription,
             lCode
    }
    
    var itemId: Int32 = 0
    var itemDescription: String
    var lCode: String
    
    init (
        itemId: Int32 = 0,
        itemDescription: String = "",
        lCode: String = ""
    ) {
        self.itemId = itemId
        self.itemDescription = itemDescription
        self.lCode = lCode
    }
}

struct PatientJ: Codable, Identifiable {
    var id = UUID()
    
    enum CodingKeys: String, CodingKey {
        case patientId,
         lastName,
         firstName,
         address1,
         address2,
         city,
         state,
         zip,
         phone,
         gender,
         dateOfBirth,
         doctorId,
         insuranceId1,
         insuranceId2
    }
    
    var patientId: Int32
    var lastName: String
    var firstName: String
    var address1: String
    var address2: String
    var city: String
    var state: String
    var zip: String
    var phone: String
    var gender: String
    var dateOfBirth: Date
    var doctorId: Int32
    var insuranceId1: Int32
    var insuranceId2: Int32
    
    init(
        patientId: Int32 = 0,
        lastName: String = "",
        firstName: String = "",
        address1: String = "",
        address2: String = "",
        city: String = "",
        state: String = "",
        zip: String = "",
        phone: String = "",
        gender: String = "",
        dateOfBirth: Date = Date(),
        doctorId: Int32 = 0,
        insuranceId1: Int32 = 0,
        insuranceId2: Int32 = 0
    ) {
        self.patientId = patientId
        self.lastName = lastName
        self.firstName = firstName
        self.address1 = address1
        self.address2 = address2
        self.city = city
        self.state = state
        self.zip = zip
        self.phone = phone
        self.gender = gender
        self.dateOfBirth = dateOfBirth
        self.doctorId = doctorId
        self.insuranceId1 = insuranceId1
        self.insuranceId2 = insuranceId2
    }
}

struct DoctorJ: Codable, Identifiable {
    var id = UUID()
    
    private enum CodingKeys: String, CodingKey {
        case doctorId,
        name,
        address1,
        address2,
        city,
        state,
        zip,
        phone,
        npiNumber
    }

    var doctorId: Int32
    var name: String
    var address1: String
    var address2: String
    var city: String
    var state: String
    var zip: String
    var phone: String
    var npiNumber: String
    
    init(
        doctorId: Int32 = 0,
        name: String = "",
        address1: String = "",
        address2: String = "",
        city: String = "",
        state: String = "",
        zip: String = "",
        phone: String = "",
        npiNumber: String = ""
    ) {
        self.doctorId = doctorId
        self.name = name
        self.address1 = address1
        self.address2 = address2
        self.city = city
        self.state = state
        self.zip = zip
        self.phone = phone
        self.npiNumber = npiNumber
    }
    
}

struct InsuranceJ: Codable, Identifiable {
    var id: UUID = UUID()
    
    private enum CodingKeys: String, CodingKey {
        case insuranceId,
        insuranceName,
        insuranceType,
        policyId,
        policyGroupId,
        diagnosis
    }
    
    var insuranceId: Int32
    var insuranceName: String
    var insuranceType: String
    var policyId: String
    var policyGroupId: String
    var diagnosis: String
    
    init (
        insuranceId: Int32 = 0,
        insuranceName: String = "",
        insuranceType: String = "",
        policyId: String = "",
        policyGroupId: String = "",
        diagnosis: String = ""
    ) {
        self.insuranceId = insuranceId
        self.insuranceName = insuranceName
        self.insuranceType = insuranceType
        self.policyId = policyId
        self.policyGroupId = policyGroupId
        self.diagnosis = diagnosis
    }
}

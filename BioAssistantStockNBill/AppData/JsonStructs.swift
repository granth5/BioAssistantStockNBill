//
//  JsonStructs.swift
//  BioAssistantStockNBill
//
//  Created by Grant on 11/10/23.
//

import Foundation

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
    var orderId: Int
    var orderDate: Date
    var lastName: String
    var firstName: String
    var insuranceType: String
    var insuranceName: String
}


struct OrderJ: Codable, Identifiable {
    var id = UUID()
    
    enum CodingKeys: String, CodingKey {
        case orderId,
            orderDate,
            patientId
    }
    
    var orderId: Int
    var orderDate: Date
    var patientId: Int
}

struct OrderItemJ: Codable, Identifiable {
    var id = UUID()
    
    enum CodingKeys: String, CodingKey {
        case itemId,
            orderId,
            orderItemId,
            quantity
    }
    
    var itemId: Int
    var orderId: Int
    var orderItemId: Int
    var quantity: Int
}

struct ItemJ: Codable, Identifiable {
    var id = UUID()
    
    enum CodingKeys: String, CodingKey {
        case itemId,
             itemDescription,
             lCode
    }
    
    var itemId: Int
    var itemDescription: String
    var lCode: String
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
         dateOfBirth
    }
    
    var patientId: Int
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
}

struct DoctorJ: Codable, Identifiable {
    var id = UUID()
    
    private enum CodingKeys: String, CodingKey {
        case doctorId,
        lastName,
        firstName,
        address1,
        address2,
        city,
        state,
        zip,
        phone,
        npiNumber
    }

    var doctorId: Int
    var lastName: String
    var firstName: String
    var address1: String
    var address2: String
    var city: String
    var state: String
    var zip: String
    var phone: String
    var npiNumber: String
    
}

struct InsuranceJ: Codable, Identifiable {
    var id: UUID = UUID()
    
    private enum CodingKeys: String, CodingKey {
        case insuranceId,
        insuranceName,
        insuranceType,
        policyId,
        policyGroupId,
        diagnosis,
        orderId,
        patientId
    }
    
    var insuranceId: Int
    var insuranceName: String
    var insuranceType: String
    var policyId: String
    var policyGroupId: String
    var diagnosis: String
    var orderId: Int
    var patientId: Int
}

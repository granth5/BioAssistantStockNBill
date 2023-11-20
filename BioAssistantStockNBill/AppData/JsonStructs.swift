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


struct OrderJ: Codable {
    var orderId: Int
    var orderDate: Date
    var patientId: Int
}

struct OrderItemJ: Codable {
    var itemId: Int
    var orderId: Int
    var orderItemId: Int
    var quantity: Int
}

struct ItemJ: Codable {
    var itemId: Int
    var itemDescription: String
    var lCode: String
}

struct PatientJ: Codable {
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

struct DoctorJ: Decodable {
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


////////
/////
//struct PatientJ: Codable {
//    var patientId: Int
//    var lastName: String
//    var firstName: String
//    var address1: String
//    var address2: String
//    var city: String
//    var state: String
//    var zip: String
//    var phone: String
//    var gender: String
//    var dateOfBirth: Date
//    
////    var doctors: [DoctorJ]
//    
//    enum CodingKeys: CodingKey {
//        case patientId
//        case lastName
//        case firstName
//        case address1
//        case address2
//        case city
//        case state
//        case zip
//        case phone
//        //case doctors
//    }
//
////  **NOTE**
////  use below / above commented out code to test using properties which are
////      arrays, arrays of objects - requires child object embedded in parent
////      in JSON data
////
////    public init(from decoder: Decoder) throws {
////        let container = try decoder.container(keyedBy: CodingKeys.self)
////        patientId = try container.decode(Int.self, forKey: .patientId)
////        lastName = try container.decode(String.self, forKey: .lastName)
////        firstName = try container.decode(String.self, forKey: .firstName)
////
////        doctors = try container.decode([DoctorJ].self, forKey: .doctors)
////    }
//
//}


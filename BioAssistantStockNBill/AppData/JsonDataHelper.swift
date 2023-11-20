//
//  JsonDataHelper.swift
//  BioAssistantStockNBill
//
//  Created by Grant on 11/4/23.
//

import Foundation


class JsonDataHelper: ObservableObject {
    @Published var listOrders = [OrderListOrderJ]()
    @Published var orders = [OrderJ]()
    @Published var orderItems = [OrderItemJ]()
    @Published var doctors = [DoctorJ]()
    @Published var patients = [PatientJ]()
    @Published var items = [ItemJ]()
    
    init() {
        //loadData()
        //let decodeOrders: [OrderListOrderJ]? = decode("OrderListData", type: [OrderListOrderJ].self)
        //if decodeOrders != nil {
        //    orders = decodeOrders!
        //}
    }
    
    
   
    func loadFromJson() {
        // fetch doctors
        let decodedDoctors: [DoctorJ]? = decode("DoctorData", type: [DoctorJ].self)
        if decodedDoctors != nil {
            doctors = decodedDoctors!
        }
        
        // fetch insurances
        let decodedIns: [Insurance]
        
        // fetch patients
        let decodedPatients: [PatientJ]? = decode("PatientData", type: [PatientJ].self)
        if decodedPatients != nil {
            patients = decodedPatients!
        }
        
        // fetch items
        let decodedItems: [ItemJ]? = decode("ItemData", type: [ItemJ].self)
        if decodedItems != nil {
            items = decodedItems!
        }
        
        // fetch orders
        let decodedOrders: [OrderJ]? = decode("OrderData", type: [OrderJ].self)
        if decodedOrders != nil {
            orders = decodedOrders!
        }
        
        // fetch order items
        let decodedOrderItems: [OrderItemJ]? = decode("OrderItemData", type: [OrderItemJ].self)
        if decodedOrderItems != nil {
            orderItems = decodedOrderItems!
        }
        
        
    }
    
    func decode<T: Decodable>(_ file: String, type: T.Type) -> T? {
        guard let url = Bundle.main.url(forResource: file, withExtension: "json")
        else {
            print("Json file not found")
            return nil
        }

        let data = try? Data(contentsOf: url)
        
        let decoder = JSONDecoder()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        
        var response: T? = nil
        
            do {
                // process data
                response = try decoder.decode(T.self, from: data!)
            } catch let DecodingError.dataCorrupted(context) {
                print(context)
            } catch let DecodingError.keyNotFound(key, context) {
                print("Key '\(key)' not found:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch let DecodingError.valueNotFound(value, context) {
                print("Value '\(value)' not found:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch let DecodingError.typeMismatch(type, context)  {
                print("Type '\(type)' mismatch:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch {
                print("error: ", error)
            }
        
        return response

    }
    
//    func loadData() {
//        guard let url = Bundle.main.url(forResource: "OrderListData", withExtension: "json")
//        else {
//            print("Json file not found")
//            return
//        }
//        
//        let data = try? Data(contentsOf: url)
//        
//        //let orders = try? JSONDecoder().decode([OrderListOrder].self, from: data!)
//        let decoder = JSONDecoder()
//        //decoder.dateDecodingStrategy = .millisecondsSince1970
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy-MM-dd"
//        decoder.dateDecodingStrategy = .formatted(dateFormatter)
//        
//            do {
//                // process data
//                self.orders = try decoder.decode([OrderListOrderJ].self, from: data!)
//            } catch let DecodingError.dataCorrupted(context) {
//                print(context)
//            } catch let DecodingError.keyNotFound(key, context) {
//                print("Key '\(key)' not found:", context.debugDescription)
//                print("codingPath:", context.codingPath)
//            } catch let DecodingError.valueNotFound(value, context) {
//                print("Value '\(value)' not found:", context.debugDescription)
//                print("codingPath:", context.codingPath)
//            } catch let DecodingError.typeMismatch(type, context)  {
//                print("Type '\(type)' mismatch:", context.debugDescription)
//                print("codingPath:", context.codingPath)
//            } catch {
//                print("error: ", error)
//            }
//    }
}

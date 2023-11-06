//
//  JsonDataHelper.swift
//  BioAssistantStockNBill
//
//  Created by Grant on 11/4/23.
//

import Foundation

struct OrderListOrder: Codable, Identifiable {
    enum CodingKeys: CodingKey {
        case orderDate
        case lastName
        case firstName
        case insuranceType
        case insuranceName
    }
    
    var id = UUID()
    var orderDate: Date
    var lastName: String
    var firstName: String
    var insuranceType: String
    var insuranceName: String

}


class ReadJsonData: ObservableObject {
    @Published var orders = [OrderListOrder]()
    
    init() {
        loadData()
    }
    
    func loadData() {
        guard let url = Bundle.main.url(forResource: "OrderData", withExtension: "json")
        else {
            print("Json file not found")
            return
        }
        
        let data = try? Data(contentsOf: url)
        
        //let orders = try? JSONDecoder().decode([OrderListOrder].self, from: data!)
        let decoder = JSONDecoder()
        //decoder.dateDecodingStrategy = .millisecondsSince1970
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        
            do {
                // process data
                self.orders = try decoder.decode([OrderListOrder].self, from: data!)
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
    }
}

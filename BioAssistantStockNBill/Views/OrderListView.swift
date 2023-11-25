//
//  OrderListView.swift
//  BioAssistantStockNBill
//
//  Created by Grant on 11/17/23.
//

import SwiftUI

private let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    return formatter
}()

struct OrderListView: View {
    @FetchRequest(sortDescriptors: []) var orders: FetchedResults<Order>
    
    var body: some View {
        Form {
            VStack {
                VStack {
                    List {
                        ForEach(orders) { order in
                            HStack {
                                Text("\(order.orderId)")
                                    .frame(width: 100)
                                Text("\(order.patient?.lastName ?? "?????")" + ", " + "\(order.patient?.firstName ?? "?????")")
                                    .frame(width: 500)
                                Text("\(dateFormatter.string(from: order.orderDate!))")
                                    .frame(width: 200)
                            }
                        }
                    }
                }
                
                Spacer()

            }
        }
    }
}

#Preview {
    OrderListView()
}

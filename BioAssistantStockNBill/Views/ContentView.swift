//
//  ContentView.swift
//  BioAssistantStockNBill
//
//  Created by Grant on 10/26/23.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var orders = ReadJsonData()
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()

    
    var body: some View {
        List(orders.orders) { order in
            VStack {
                HStack {
                    Text(dateFormatter.string(from: order.orderDate))
                    Spacer()
                    Text(order.lastName)
                    Spacer()
                    Text(order.firstName)
                    Spacer()
                    Text(order.insuranceType)
                    Spacer()
                    Text(order.insuranceName)
                    Spacer()
                    Button("Edit") {
                        
                    }
                    Spacer()
                    Button("Delete") {
                        
                    }
                }
            }
        }

        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().previewInterfaceOrientation(.landscapeLeft)
    }
}

#Preview {
    ContentView()
}

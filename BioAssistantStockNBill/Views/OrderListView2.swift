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

struct OrderListView2: View {
    @EnvironmentObject var cdDatataController: CDDataController
    @State var orderList = [OrderListOrderJ]()
    @State var orderToEdit = OrderEditInfo()
    @State private var action: Int? = 0
    @State private var selectedOrderId: Int32 = 0
    @State private var editViewSelected: Bool = false
    
    
//    init() {
//        orderList = cdDatataController.getOrderList()
//    }
    
    var body: some View {

        NavigationView {
            
            VStack {

                VStack {
                    
                    
                    VStack {
                        HStack {
                            Text("Order ID")
                                .frame(width: 75, height: 30, alignment: .leading)
                                .border(width: 1, edges: [.bottom], color: .blue)
                            Text("Patient")
                                .frame(width: 300, height: 30, alignment: .leading)
                                .border(width: 1, edges: [.bottom], color: .blue)
                            Text("Order Dt")
                                .frame(width: 100, height: 30)
                                .border(width: 1, edges: [.bottom], color: .blue)
                            Text("** Actions **")
                                .frame(width: 100, height: 30)
                                .border(width: 1, edges: [.bottom], color: .blue)
                            Spacer()
                        }
                        .padding()
                        
                        VStack {
                            List {
                                
                                ForEach(cdDatataController.getOrderList()) { order in
                                    
                                    HStack {
                                        
                                        Text("\(order.orderId)")
                                            .frame(width: 75, height: 30)
                                            .border(.blue)
                                        
                                        Text(" \(order.lastName)" + ", " + "\(order.firstName)")
                                            .frame(width: 300, height: 30, alignment: .leading)
                                            .border(.blue)
                                        
                                        Text("\(dateFormatter.string(from: order.orderDate))")
                                            .frame(width: 100, height: 30)
                                            .border(.blue)
                                        
                                       
                                        Text("Edit").onTapGesture {
                                            selectedOrderId = order.orderId
                                            self.editViewSelected = true
                                        }
                                        .frame(width: 75, height: 30)
                                        .border(.blue)
                                        .tint(.blue)

                                        Text("Delete").onTapGesture {
                                            print("**DELETE!!!**")
                                        }
                                        .frame(width: 75, height: 30)
                                        .border(.blue)
                                        .tint(.blue)
                                        
                                        Spacer()
                                    }
                                    .padding([.bottom], 2)
                                    
                                }
                                
                            }
                            .listStyle(PlainListStyle())
                            
                          }
                            
                        }
                        
                    }
                    
                    Spacer()
                    
                    
                    
                    Spacer()
                    
                    Button("ADD") {
                        print("***ADD***")
                        self.selectedOrderId = 0
                        self.editViewSelected = true
                        
                    }
                    .buttonStyle(.bordered)
                    .tint(.blue)
                    
                }
                .sheet(isPresented: $editViewSelected) {
                EditView(passedOrderId: selectedOrderId)
            }
        }
        .border(.blue)
        .navigationViewStyle(StackNavigationViewStyle())
    }
        
}


#Preview {
    OrderListView2()
}


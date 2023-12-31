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
    @EnvironmentObject var cdDatataController: CDDataController
    @State var orderList = [OrderListOrderJ]()
    @State var orderToEdit = OrderEditInfo()
    
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
                                        
                                        NavigationLink("Edit") {
                                            EditView(passedOrderId: order.orderId)
                                        }
                                        .frame(width: 75, height: 30)
                                        .border(.blue)
                                        .tint(.blue)
                                        .buttonStyle(.borderedProminent)
                                        
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
                        EditView(passedOrderId: 0)
                        
                    }
                    .buttonStyle(.bordered)
                    .tint(.blue)
                    
                }
            }
            .border(.blue)
            .navigationViewStyle(StackNavigationViewStyle())
    }
        
}


#Preview {
    OrderListView()
}

extension View {
    func border(width: CGFloat, edges: [Edge], color: Color) -> some View {
        overlay(EdgeBorder(width: width, edges: edges).foregroundColor(color))
    }
}

struct EdgeBorder: Shape {
    var width: CGFloat
    var edges: [Edge]

    func path(in rect: CGRect) -> Path {
        edges.map { edge -> Path in
            switch edge {
            case .top: return Path(.init(x: rect.minX, y: rect.minY, width: rect.width, height: width))
            case .bottom: return Path(.init(x: rect.minX, y: rect.maxY - width, width: rect.width, height: width))
            case .leading: return Path(.init(x: rect.minX, y: rect.minY, width: width, height: rect.height))
            case .trailing: return Path(.init(x: rect.maxX - width, y: rect.minY, width: width, height: rect.height))
            }
        }.reduce(into: Path()) { $0.addPath($1) }
    }
}


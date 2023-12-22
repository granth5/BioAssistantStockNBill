//
//  EditView.swift
//  BioAssistantStockNBill
//
//  Created by Grant on 11/27/23.
//

import SwiftUI

struct EditView: View {
    @EnvironmentObject var cdDatataController: CDDataController
    @State var passedOrderId: Int32 = 0
    @State var orderToEdit: OrderEditInfo = OrderEditInfo()
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack {
            VStack {
                TabView {
                    EditView_Patient(orderToEdit: $orderToEdit)
                        .tabItem {
                            Label("Patient", systemImage: "list.bullet")
                        }
                    EditView_Items(passedOrderId: passedOrderId)
                        .tabItem {
                            Label("Items", systemImage: "list.bullet")
                        }
                }
                
                Spacer()
            }
            .onAppear() {
                orderToEdit = cdDatataController.getOrderEditInfo(orderId: passedOrderId)
                var ghh1 = orderToEdit
            }
            Button("Save") {
                dismiss()
            }
        }
        .border(.red)
        .frame(maxHeight: .infinity)
    }
}


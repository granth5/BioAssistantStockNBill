//
//  EditView_Patient.swift
//  BioAssistantStockNBill
//
//  Created by Grant on 11/27/23.
//

import SwiftUI
import CoreData

struct EditView_Patient: View {
    @Environment(\.dismiss) private var dismiss
    
    @Binding var orderToEdit: OrderEditInfo
    
    var body: some View {
        Form {
            Section(header: Text("Patient Info:")) {
                HStack {
                    Text("Last Name:").font(.headline)
                        .frame(width: 100)
                    TextField("Last Name...", text: $orderToEdit.patientInfo.patient.lastName)
                        .frame(width: 200)
                    Text("First Name:").font(.headline)
                        .frame(width: 100)
                    TextField("First Name...", text: $orderToEdit.patientInfo.patient.firstName)
                        .frame(width: 200)
                    Spacer()
                }
                
                Section(header: Text("Insurance Info:")) {
                    HStack {
                        Text("Insurance Type:").font(.headline)
                            .frame(width: 100)
                        TextField("Insurance Type...", text: $orderToEdit.patientInfo.insurance1.insuranceType)
                        .frame(width: 200)
                        Text("Insurance Name:").font(.headline)
                            .frame(width: 100)
                        TextField("Insurance Name...", text: $orderToEdit.patientInfo.insurance1.insuranceName)
                        .frame(width: 200)
                        Spacer()
                    }
                }
//                Button("Save") {
//                    dismiss()
//                }
            }
            .onAppear {
                var ghh1 = 0
            }
        }
    }
}

   

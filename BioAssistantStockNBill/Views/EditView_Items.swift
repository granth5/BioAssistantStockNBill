//
//  EditView_Items.swift
//  BioAssistantStockNBill
//
//  Created by Grant on 11/27/23.
//

import SwiftUI

struct EditView_Items: View {
    @State var passedOrderId: Int32 = 0
    
    init(passedOrderId: Int32) {
        self.passedOrderId = passedOrderId
    }
    
    var body: some View {
        Text(" *** ITEMS: Order ID: \(passedOrderId)")
    }
}

#Preview {
    EditView_Items(passedOrderId: 0)
}

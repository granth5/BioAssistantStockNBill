//
//  BioAssistantStockNBillApp.swift
//  BioAssistantStockNBill
//
//  Created by Grant on 10/26/23.
//

import SwiftUI

@main
struct BioAssistantStockNBillApp: App {
    @StateObject private var cdDataController = CDDataController()
    
    var body: some Scene {
        WindowGroup {
            
            ContentView(cdDataController: cdDataController)
                .environment(\.managedObjectContext, cdDataController.container.viewContext)
        }
    }
}

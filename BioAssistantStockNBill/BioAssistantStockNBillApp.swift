//
//  BioAssistantStockNBillApp.swift
//  BioAssistantStockNBill
//
//  Created by Grant on 10/26/23.
//

import SwiftUI

@main
struct BioAssistantStockNBillApp: App {
    
    let cdDataController = CDDataController.shared

    init() {
        cdDataController.loadDataFromCd()
    }
    
    var body: some Scene {
        WindowGroup {
            
            ContentView()
                //.environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(cdDataController)
        }
    }
}

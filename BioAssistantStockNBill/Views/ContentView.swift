//
//  ContentView.swift
//  BioAssistantStockNBill
//
//  Created by Grant on 10/26/23.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var cdDataController: CDDataController
    @ObservedObject var jsonHelper: JsonDataHelper
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    init(cdDataController: CDDataController) {
        self.cdDataController = cdDataController
        self.jsonHelper = JsonDataHelper()
    }

    
    var body: some View {
        TabView {
            OrderListView()
                .tabItem {
                    Label("Orders", systemImage: "list.bullet")
                }
            DataAssistView(cdDataController: cdDataController)
                .environmentObject(jsonHelper)
                .tabItem {
                    Label("Data Utils", systemImage: "swiftdata")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(cdDataController: CDDataController()).previewInterfaceOrientation(.landscapeLeft)
    }
}

#Preview {
    ContentView(cdDataController: CDDataController())
}

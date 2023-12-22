//
//  ContentView.swift
//  BioAssistantStockNBill
//
//  Created by Grant on 10/26/23.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var jsonHelper: JsonDataHelper
    
    @EnvironmentObject var cdDataController: CDDataController
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    init() {
        self.jsonHelper = JsonDataHelper()
    }

    
    var body: some View {
        TabView {
            OrderListView2()
                .tabItem {
                    Label("Orders", systemImage: "list.bullet")
                }
            DataAssistView()
                .environmentObject(jsonHelper)
                //.environmentObject(cdDataController)
                .tabItem {
                    Label("Data Utils", systemImage: "swiftdata")
                }
        }
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

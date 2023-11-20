//
//  DataAssistView.swift
//  BioAssistantStockNBill
//
//  Created by Grant on 11/11/23.
//

import SwiftUI

struct DataAssistView: View {
    @ObservedObject var cdDataController: CDDataController
    //@ObservedObject var jsonHelper: JsonDataHelper
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.isPresented) private var isPresented
    
    @EnvironmentObject var jsonHelper: JsonDataHelper
    
    @State var jsonLoaded: Bool = false
    @State var cdDataLoaded: Bool = false
    
    // 'Utility' view to do various data / backend related stuff
    //
    // Ideas...
    // - show current staus:
    //  - Unitialized (Sqlite DB empty)
    //  - Initialized (Sqlite DB empty)
    
    init(cdDataController: CDDataController) {
        self.cdDataController = cdDataController
    }
    
    
    var body: some View {
        VStack {
            Label("TEST", systemImage: "bolt.fill")
            VStack {
                HStack {
                    Toggle("JSON Data Loaded", isOn: $jsonLoaded)
                        .frame(width: 250)
                        .padding()
                        .disabled(true)
                    Toggle("CD Data Loaded", isOn: $cdDataController.cdDataLoaded)
                        .frame(width: 200)
                        .padding()
                        .disabled(true)
                    Spacer()
                }
                HStack {
                    Button("Load JSON Data", action: {
                        if !jsonLoaded {
                            jsonHelper.loadFromJson()
                            jsonLoaded = !self.jsonHelper.patients.isEmpty
                        }
                    })
                    .frame(width: 200)
                    .buttonStyle(.bordered)
                    .buttonBorderShape(.roundedRectangle)
                    .padding()

                    Button("Load CD Data", action: {
                        if !cdDataLoaded {
                            cdDataController.jsonHelper = jsonHelper
                            cdDataController.test()
                        }
                    })
                    .frame(width: 200)
                    .buttonStyle(.bordered)
                    .buttonBorderShape(.roundedRectangle)
                    .padding()

                    Spacer()
                }
            }

            Spacer()
        }
    }
}

struct DataAssistView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(cdDataController: CDDataController()).previewInterfaceOrientation(.landscapeLeft)
    }
}



#Preview {
    DataAssistView(cdDataController: CDDataController())
}

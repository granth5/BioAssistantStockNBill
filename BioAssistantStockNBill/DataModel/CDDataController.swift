//
//  CDDataController.swift
//  BioAssistantStockNBill
//
//  Created by Grant on 11/10/23.
//

// GHH - NOTE: updated w/various state indicators

import Foundation
import CoreData

class CDDataController: ObservableObject {
    @Published var jsonHelper: JsonDataHelper
    
    let container = NSPersistentContainer(name: "BioAssistDataModel")
    
    public var cdDataLoaded: Bool = false

    
    
    init() {
        
        self.jsonHelper = JsonDataHelper()
        
        container.loadPersistentStores { desc, error in
            if let error = error {
                print("Failed to load \(error.localizedDescription)")
            }
            
            // create new background context
            let ctx = self.container.newBackgroundContext()
            
            // if needed, ensure background ctx stays up
            //  to date with changes from parent
            ctx.automaticallyMergesChangesFromParent = true;

            do {
                // create fetch req
                let fetchReq: NSFetchRequest<Patient>

                fetchReq = Patient.fetchRequest()
                fetchReq.fetchLimit = 1

                let objects = try ctx.fetch(fetchReq)

                // if we got here, no problems
                self.cdDataLoaded = !objects.isEmpty

            }
            catch let error {
                print("Error: " + error.localizedDescription)
            }
        }
    }
    
    func loadCdDataFromJson() {
        // ins.
        jsonHelper
    }
    
    func  test() {
        var ghh1 = jsonHelper.patients.count
        var ghh2 = 0
    }
    
    func save(context: NSManagedObjectContext) {
        do {
            try context.save()
            print("Data Saved")
        } catch {
            print("Error in save()")
        }
    }
    
    
   
}

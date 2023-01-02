//
//  ContactsProvider.swift
//  MyRidesOrDies
//
//  Created by Lisandro Falconi on 02/01/2023.
//

import Foundation
import CoreData

// Manage and intercat with data
final class ContactsProvider {
    
    static let shared = ContactsProvider()
    
    private let persistentContainer: NSPersistentContainer
    
    var viewContext: NSManagedObjectContext {
        persistentContainer.viewContext
    }
    
    var newContext: NSManagedObjectContext {
        persistentContainer.newBackgroundContext()
    }
    
    private init() {
        
        // 1. Create the contaienr
        persistentContainer = NSPersistentContainer(name: "ContactsDataModel") // exact like ContactsDataModel.xcdatamodeld
        persistentContainer.viewContext.automaticallyMergesChangesFromParent = true
        persistentContainer.loadPersistentStores { _, error in
            if let error {
                fatalError("Unable to lead store with error: \(error.localizedDescription)")
            }
        }
        
    }
    
}

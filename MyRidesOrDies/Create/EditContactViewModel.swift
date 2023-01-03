//
//  EditContactViewModel.swift
//  MyRidesOrDies
//
//  Created by Lisandro Falconi on 02/01/2023.
//

import Foundation
import CoreData

final class EditContactViewModel: ObservableObject {
    
    @Published var contact: Contact
    let isNew: Bool
    private let context: NSManagedObjectContext
    private let provider: ContactsProvider
    init(provider: ContactsProvider, contact: Contact? = nil) {
        self.provider = provider
        self.context = provider.newContext
        
        if let contact,
           let existingContactCopy = provider.exists(contact, in: context) {
            self.contact = existingContactCopy
            self.isNew = false
        } else {
            self.contact = Contact(context: self.context)
            self.isNew = true
        }
    }
    
    func save() throws {
        try provider.persist(in: context)
    }
}

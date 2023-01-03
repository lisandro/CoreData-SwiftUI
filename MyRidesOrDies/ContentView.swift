//
//  ContentView.swift
//  MyRidesOrDies
//
//  Created by Lisandro Falconi on 02/01/2023.
//

import SwiftUI

struct SearchConfig: Equatable {
    var query: String = ""
}

struct ContentView: View {
    @FetchRequest(fetchRequest: Contact.all()) private var contacts
    @State private var contactToEdit: Contact?
    @State private var searchConfig = SearchConfig()
    var provider = ContactsProvider.shared
    
    
    var body: some View {
        NavigationStack {
            ZStack {
                if contacts.isEmpty {
                    NoContactsView()
                } else {
                    List {
                        ForEach(contacts) { contact in
                            ZStack(alignment: .leading) {
                                NavigationLink(destination: ContactDetailView(contact: contact)) {
                                    EmptyView()
                                }
                                .opacity(0)
                                
                                ContactRowView(contact: contact, provider: provider)
                                    .swipeActions(allowsFullSwipe: true) {
                                        Button(role: .destructive) {
                                            do {
                                                try provider.delete(contact, in: provider.newContext)
                                            } catch {
                                                print(error)
                                            }
                                        } label: {
                                            Label("Delete", systemImage: "trash")
                                        }
                                        .tint(.red)
                                        
                                        Button(role: .destructive) {
                                            contactToEdit = contact
                                        } label: {
                                            Label("Edit", systemImage: "pencil")
                                        }
                                        .tint(.orange)

                                    }
                            }
                        }
                    }
                }
            }
            .searchable(text: $searchConfig.query)
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        contactToEdit = .empty(context: provider.newContext)
                    } label: {
                        Image(systemName: "plus").font(.title2)
                    }
                }
            }
            .sheet(item: $contactToEdit, onDismiss: {
                contactToEdit = nil
            }, content: { contact in
                NavigationStack {
                    CreateContactView(vm: .init(provider: provider, contact: contact))
                }
            })
            .onChange(of: searchConfig, perform: { newValue in
                contacts.nsPredicate = Contact.filter(newValue.query)
            })
            .navigationTitle("Contacts")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let preview = ContactsProvider.shared
        ContentView(provider: preview)
            .environment(\.managedObjectContext, preview.viewContext)
            .previewDisplayName("Contacts with data")
            .onAppear {
                Contact.makePreview(count: 10, in: preview.viewContext)
            }
        
        
        let emptyPreview = ContactsProvider.shared
        ContentView(provider: emptyPreview)
            .environment(\.managedObjectContext, preview.viewContext)
            .previewDisplayName("Contacts with no data")
    }
}


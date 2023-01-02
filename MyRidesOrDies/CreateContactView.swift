//
//  CreateContactView.swift
//  MyRidesOrDies
//
//  Created by Lisandro Falconi on 02/01/2023.
//

import SwiftUI

struct CreateContactView: View {
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        List {
            Section("General") {
                
                TextField("Name", text: .constant(""))
                    .keyboardType(.namePhonePad)
                
                TextField("Email", text: .constant(""))
                    .keyboardType(.emailAddress)
                
                TextField("Phone Number", text: .constant(""))
                    .keyboardType(.namePhonePad)
                
                DatePicker("Birthday", selection: .constant(.now), displayedComponents: [.date])
                    .datePickerStyle(.compact)
                
                Toggle("Favourite", isOn: .constant(true))
            }
            
            Section("Notes") {
                
                TextField("",
                          text: .constant("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."),
                          axis: .vertical)

            }
        }
        .navigationTitle("Name Here")
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button("Done") {
                    dismiss()
                }
            }
            
            ToolbarItem(placement: .navigationBarLeading) {
                Button("Cancel") {
                    dismiss()
                }
            }
        }
    }
}

struct CreateContactView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            CreateContactView()
        }
    }
}

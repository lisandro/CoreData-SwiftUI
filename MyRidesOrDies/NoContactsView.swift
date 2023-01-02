//
//  NoContactView.swift
//  MyRidesOrDies
//
//  Created by Lisandro Falconi on 02/01/2023.
//

import SwiftUI

struct NoContactsView: View {
    var body: some View {
        VStack {
            Text("👀 No Contacts")
                .font(.largeTitle.bold())
            
            Text("It's seems a lil empty here create some contacts ☝🏾")
                .font(.callout)
        }
    }
}

struct NoContactView_Previews: PreviewProvider {
    static var previews: some View {
        NoContactsView()
    }
}

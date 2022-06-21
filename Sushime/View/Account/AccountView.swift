//
//  AccountView.swift
//  Sushime
//
//  Created by Manuel Andruccioli on 19/06/22.
//

import SwiftUI
import Foundation

struct AccountView: View {
    var body: some View {
        VStack {
            Text("Account")
                .font(.largeTitle)
            Divider()
            UserFormView()
                .padding()
            Divider()
            Text("I tuoi ordini")
                .font(.largeTitle)
            List {
                Text("Ciao")
                Text("Ciao")
                Text("Ciao")
                Text("Ciao")
                Text("Ciao")
                Text("Ciao")
            }
        }
        .padding()
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
    }
}

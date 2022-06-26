//
//  WaitingToJoinView.swift
//  Sushime
//
//  Created by Manuel Andruccioli on 26/06/22.
//

import SwiftUI

struct WaitingForConnectionView: View {
    var body: some View {
        VStack {
            Spacer()
            Text("In attesa della connessione...")
                .font(.title3)
                .padding()
            ProgressView()
                .scaleEffect(1.5)
            Spacer()
        }
    }
}

struct WaitingForConnectionView_Previews: PreviewProvider {
    static var previews: some View {
        WaitingForConnectionView()
    }
}

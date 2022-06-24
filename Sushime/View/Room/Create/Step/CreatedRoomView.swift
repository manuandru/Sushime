//
//  CreateRoomView.swift
//  Sushime
//
//  Created by Manuel Andruccioli on 24/06/22.
//

import SwiftUI

struct CreatedRoomView: View {
    
    @Binding var createStep: CreateViewStep
    
    var body: some View {
        VStack {
            Spacer()
            Text("La stanza creata\ncon successo ✅")
                .font(.largeTitle)
            
            Text("Condividi il codice con i tuoi amici")
                .font(.title3)
            
            Spacer()
            
            Button {
                withAnimation {
                    createStep = .order
                }
            } label: {
                Text("Prosegui")
                    .font(.largeTitle)
            }
            .buttonStyle(.borderedProminent)
        }
    }
}

struct CreatedRoomView_Previews: PreviewProvider {
    static var previews: some View {
        CreatedRoomView(createStep: .constant(.created))
    }
}

//
//  OrderMenuRoomView.swift
//  Sushime
//
//  Created by Manuel Andruccioli on 24/06/22.
//

import SwiftUI

struct OrderMenuRoomView: View {
//    @EnvironmentObject var appPath: AppPath
//    @EnvironmentObject var mqtt: WrapperMQTT
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Categoria.id, ascending: true)])
    private var categorie: FetchedResults<Categoria>
    
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

struct OrderMenuRoomView_Previews: PreviewProvider {
    
    private static func createRistorante() -> Ristorante {
        let ristorante = Ristorante(context: PersistenceController.preview.container.viewContext)
        ristorante.id = 1
        ristorante.nome = "Ristorante di prova"
        ristorante.descrizione = "Bel ristorante di prova"
        
        return ristorante
    }
    
    static var previews: some View {
        OrderMenuRoomView(createStep: .constant(.order))
    }
}

//
//  RestaurantDetailView.swift
//  Sushime
//
//  Created by Manuel Andruccioli on 23/06/22.
//

import SwiftUI

struct RestaurantDetailView: View {
    
    var ristorante: Ristorante
    
    @FetchRequest(sortDescriptors: [])
    private var piatti: FetchedResults<Piatto>
    
    
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Categoria.id, ascending: true)])
    private var categorie: FetchedResults<Categoria>
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            
            Image(uiImage: ristorante.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .cornerRadius(15)
                .padding(.bottom)
            
            Text(ristorante.unwrappedDescrizione)
            
            Divider()
            
            Text("Menu")
                .font(.largeTitle)
                .padding()
            
            ForEach(categorie) { categoria in
                VStack(alignment: .leading) {
                    Text(categoria.unwrappedNome)
                        .font(.title2)
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(categoria.piattiArray) { piatto in
                                PiattoSquareView(piatto: piatto)
                            }
                        }
                    }
                }
                
                Divider()
            }
            
        }
        .padding()
    }
}

struct RestaurantDetailView_Previews: PreviewProvider {
    
    
    private static func createRistorante() -> Ristorante {
        let ristorante = Ristorante(context: PersistenceController.preview.container.viewContext)
        ristorante.id = 1
        ristorante.nome = "Ristorante di prova"
        ristorante.descrizione = "Bel ristorante di prova"
        
        return ristorante
    }
    
    static var previews: some View {
        RestaurantDetailView(ristorante: createRistorante())
    }
}

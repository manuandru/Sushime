//
//  RestaurantView.swift
//  Sushime
//
//  Created by Manuel Andruccioli on 19/06/22.
//

import SwiftUI

struct RestaurantView: View {
    
    @State private var str = ""
    @State private var presentGPS = false

    @FetchRequest(sortDescriptors: [])
    private var ristoranti: FetchedResults<Ristorante>

    var body: some View {
        NavigationView {
            List {
                ForEach(ristoranti.filter( { str == "" ? true : $0.nome?.contains(str) ?? true } )) { ristorante in
                    NavigationLink {
                        Text("Item at \(ristorante.nome ?? "Errore")")
                    } label: {
                        Text(ristorante.nome ?? "ristorante")
                            .font(.title2)
                    }
                }
            }
            .toolbar {
                ToolbarItem {
                    Button {
                        presentGPS.toggle()
                    } label: {
                        Image(systemName: "location.fill")
                    }
                }
            }
            .navigationTitle("Ristoranti")
            .navigationBarTitleDisplayMode(.large)
            .searchable(text: $str, prompt: "Cerca")
            .sheet(isPresented: $presentGPS) {
                GPSView()
            }
        }
    }
}

struct RestaurantView_Previews: PreviewProvider {
    static var previews: some View {
        RestaurantView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}

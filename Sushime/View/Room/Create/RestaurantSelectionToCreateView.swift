//
//  RestaurantSelectionToCreateView.swift
//  Sushime
//
//  Created by Manuel Andruccioli on 24/06/22.
//

import SwiftUI

struct RestaurantSelectionToCreateView: View {
    
    @Binding var activeSheet: ActiveSheet?
    
    @State var filter: String = ""
    
    @FetchRequest(sortDescriptors: [])
    private var ristoranti: FetchedResults<Ristorante>
    
    @State var selectedRestaurant: Ristorante?
    
    var body: some View {
        VStack {
            
            HStack {
                Button {
                    withAnimation {
                        activeSheet = .none
                    }
                } label: {
                    Image(systemName: "xmark")
                        .resizable()
                        .scaledToFit()
                }
                
                Spacer()
                
                Button {
                    withAnimation {
                        activeSheet = .none
                    }
                } label: {
                    Image(systemName: "xmark")
                        .resizable()
                        .scaledToFit()
                }
                .frame(height: 20)
                .disabled(selectedRestaurant == nil)
            }
            .frame(height: 20)
            .padding([.top, .leading, .trailing])
            
            Text("Seleziona il ristorante")
                .font(.largeTitle)
            
            
            TextField("Ricerca", text: $filter, onEditingChanged: {_ in print("OK")})
                .padding()
                .disableAutocorrection(true)
            
            List(ristoranti.filter({ filter == "" ? true : $0.unwrappedNome.contains(filter) })) { ristorante in
                SelectableRow(selectedRestaurant: $selectedRestaurant, mySelfRestaurant: ristorante)
            }
        }
    }
}

struct RestaurantSelectionToCreateView_Previews: PreviewProvider {
    static var previews: some View {
        RestaurantSelectionToCreateView(activeSheet: .constant(.create))
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}

struct SelectableRow: View {

    @Binding var selectedRestaurant: Ristorante?
    
    let mySelfRestaurant: Ristorante
    
    var body: some View {
        HStack {
            Text(mySelfRestaurant.unwrappedNome)
            Spacer()
            if mySelfRestaurant == selectedRestaurant {
                Image(systemName: "checkmark")
                    .foregroundColor(.accentColor)
            }
        }
        .contentShape(Rectangle())
        .onTapGesture {
            selectedRestaurant = mySelfRestaurant
        }
    }
}


struct SelectableRow_Previews: PreviewProvider {
    
    private static func createRistorante() -> Ristorante {
        let ristorante = Ristorante(context: PersistenceController.preview.container.viewContext)
        ristorante.id = 1
        ristorante.nome = "Ristorante di prova"
        ristorante.descrizione = "Bel ristorante di prova"
        return ristorante
    }
    
    static var ristorante: Ristorante = SelectableRow_Previews.createRistorante()
    
    static var previews: some View {
        SelectableRow(selectedRestaurant: .constant(ristorante), mySelfRestaurant: ristorante)
            .previewLayout(.sizeThatFits)
            .preferredColorScheme(.dark)
            .frame(width: nil)
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
        SelectableRow(selectedRestaurant: .constant(.none), mySelfRestaurant: ristorante)
            .previewLayout(.fixed(width: 400, height: /*@START_MENU_TOKEN@*/100.0/*@END_MENU_TOKEN@*/))
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}

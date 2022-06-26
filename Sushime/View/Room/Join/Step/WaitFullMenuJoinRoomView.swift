//
//  WaitFullMenuJoinRoomView.swift
//  Sushime
//
//  Created by Manuel Andruccioli on 26/06/22.
//

import SwiftUI

struct WaitFullMenuJoinRoomView: View {
    
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(sortDescriptors: [])
    private var ordini: FetchedResults<Ordine>
    @FetchRequest(sortDescriptors: [])
    private var piattiInOrdine: FetchedResults<PiattoInOrdine>
    @FetchRequest(sortDescriptors: [])
    private var ristoranti: FetchedResults<Ristorante>
    @FetchRequest(sortDescriptors: [])
    private var piatti: FetchedResults<Piatto>
    
    @EnvironmentObject var mqtt: WrapperMQTTClient

    @Binding var selectedPiatti: Dictionary<Piatto, Int>
    
    var body: some View {
        VStack {
            Text("Ordine complessivo")
                .font(.largeTitle)
            
            if !mqtt.finalMenu.isEmpty {
                List {
                    ForEach(mqtt.finalMenu.sorted(by: {$0.key > $1.key}), id: \.key) { piatto, quantita in
                        HStack {
                            Text(piatti.first(where: { $0.id == piatto })?.unwrappedNome ?? "error piatto")
                            Spacer()
                            Text(String(quantita))
                        }
                    }
                }
                .onAppear {
                    saveNewOrderToDB()
                }
            } else {
                Spacer()
                Text("Il Creatore deve ancora terminare...")
                    .font(.title3)
                    .padding()
                ProgressView()
                    .scaleEffect(1.5)
                    .padding()
                Spacer()
            }
            
        }
    }
        
    
    private func saveNewOrderToDB() {

        let newOrdine = Ordine(context: viewContext)
        newOrdine.id = Int32(ordini.count)

        if let restaurantId = mqtt.restaurantId {
            newOrdine.ristorante = ristoranti.first(where: { $0.id == restaurantId })
        } else {
            newOrdine.ristorante = ristoranti.first
        }
        newOrdine.data = Date()
        try? viewContext.save()

        for piatto in selectedPiatti.enumerated() {
            let newPiattoInOrdine = PiattoInOrdine(context: viewContext)
            newPiattoInOrdine.id = Int32(piattiInOrdine.count)
            newPiattoInOrdine.quantita = Int32(piatto.element.value)
            newPiattoInOrdine.piatto = piatto.element.key
            newPiattoInOrdine.ordine = newOrdine

            try? viewContext.save()
        }

    }
    
}

//struct WaitFullMenuJoinRoomView_Previews: PreviewProvider {
//    static var previews: some View {
//        WaitFullMenuJoinRoomView()
//    }
//}

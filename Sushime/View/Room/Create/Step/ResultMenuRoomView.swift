//
//  ResultMenuRoomView.swift
//  Sushime
//
//  Created by Manuel Andruccioli on 25/06/22.
//

import SwiftUI

struct ResultMenuRoomView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(sortDescriptors: [])
    private var ordini: FetchedResults<Ordine>
    @FetchRequest(sortDescriptors: [])
    private var piattiInOrdine: FetchedResults<PiattoInOrdine>
    
    @EnvironmentObject var mqtt: WrapperMQTT
    @EnvironmentObject var appPath: AppPath
    
    @Binding var createStep: CreateViewStep
    
    @Binding var selectedPiatti: Dictionary<Piatto, Int>
    
    @State var isDialogShown = false
    
    var body: some View {
        VStack {
            Text("Ordini")
                .font(.largeTitle)
            
            NavigationView {
                List {
                    Section {
                        NavigationLink {
                            Text("Il tuo ordine")
                                .font(.largeTitle)
                            MyOrderView(order: selectedPiatti)
                        } label: {
                            Text("Il tuo ordine")
                        }
                    }
                    Section {
                        ForEach($mqtt.creationState.users, id: \.self) { user in
                            NavigationLink {
                                Text("\(user.name.wrappedValue)")
                                        .font(.largeTitle)
                                GuestOrderView(order: user.orders.wrappedValue)
                            } label: {
                                Text("\(user.name.wrappedValue)")
                            }
                        }
                    }
                }
            }
            
            
            HStack {
                Button {
                    withAnimation {
                        createStep = .confirm
                    }
                } label: {
                    Text("Indietro")
                        .font(.largeTitle)
                }
                .buttonStyle(.borderedProminent)
                .padding([.top])
                
                Button(role: .destructive) {
                    isDialogShown.toggle()
                } label: {
                    Text("Termina")
                        .font(.largeTitle)
                }
                .buttonStyle(.borderedProminent)
                .padding([.top])
                .disabled(selectedPiatti.isEmpty)
                .confirmationDialog(
                    "Stai per concludere l'ordine, assicurati che tutti abbiano terminato",
                    isPresented: $isDialogShown,
                    actions: {
                        Button(role: .destructive) {
                            
                            saveOrderInDB()
                            mqtt.generateFinalMenu(from: selectedPiatti)
                            withAnimation {
                                createStep = .mergedMenu
                            }
                            
                            
                        } label: {
                            Text("Termina tavolo")
                        }
                        Button(role: .cancel) {} label: {
                            Text("Non abbiamo ancora finito...")
                        }
                    },
                    message: {
                        Text("Stai per concludere l'ordine, assicurati che tutti abbiano terminato")
                    }
                )
            }
        }
    }
    
    
    
    func saveOrderInDB() {
        
        // TODO: save viewContext
        
        let newOrdine = Ordine(context: viewContext)
        newOrdine.id = Int32(ordini.count)
        newOrdine.ristorante = appPath.joinedRestaurant
        newOrdine.data = Date()
        try? viewContext.save()
        
        for piatto in selectedPiatti {
            let newPiattoInOrdine = PiattoInOrdine(context: viewContext)
            newPiattoInOrdine.id = Int32(piattiInOrdine.count)
            newPiattoInOrdine.quantita = Int32(piatto.value)
            newPiattoInOrdine.piatto = piatto.key
            newPiattoInOrdine.ordine = newOrdine
            
            try? viewContext.save()
        }
    }
}


struct MyOrderView: View {
    
    var order: Dictionary<Piatto, Int>
    
    var body: some View {
        List {
            ForEach(order.sorted(by: {$0.key.id > $1.key.id}), id: \.key.id) { piatto, quantita in
                HStack {
                    Text(piatto.unwrappedNome)
                    Spacer()
                    Text(String(quantita))
                }
            }
        }
    }
}

struct GuestOrderView: View {
    var order: Dictionary<Int, Int>
    
    @FetchRequest(sortDescriptors: [])
    private var piatti: FetchedResults<Piatto>
    
    var body: some View {
        List {
            ForEach(order.sorted(by: {$0.key > $1.key}), id: \.key) { piatto, quantita in
                HStack {
                    Text(piatti.first(where: { $0.id == piatto })?.unwrappedNome ?? "error piatto")
                    Spacer()
                    Text(String(quantita))
                }
            }
        }
    }
}

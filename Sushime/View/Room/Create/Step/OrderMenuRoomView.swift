//
//  OrderMenuRoomView.swift
//  Sushime
//
//  Created by Manuel Andruccioli on 24/06/22.
//

import SwiftUI

struct OrderMenuRoomView: View {
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Categoria.id, ascending: true)])
    private var categorie: FetchedResults<Categoria>
    
    @Binding var createStep: CreateViewStep
    
    @Binding var selectedPiatti: Dictionary<Piatto, Int>
    @State var detailOfPiatto: Piatto?
    
    var body: some View {
        ScrollView {
            Text("Menu")
                .font(.largeTitle)
            
            Spacer()
            
            
            ForEach(categorie) { categoria in
                VStack(alignment: .leading) {
                    Text(categoria.unwrappedNome)
                        .font(.title2)
                        .padding()
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(categoria.piattiArray) { piatto in
                                PiattoSquareForOrder(piatto: piatto,
                                                     backgroundColor: selectedPiatti.keys.contains(piatto) ? .systemGreen : .systemFill)
                                    .onTapGesture {
                                        if selectedPiatti.keys.contains(piatto) {
                                            selectedPiatti.removeValue(forKey: piatto)
                                        } else {
                                            selectedPiatti[piatto] = 1
                                        }
                                        let impactHeavy = UIImpactFeedbackGenerator(style: .soft)
                                        impactHeavy.impactOccurred()
                                    }
                                    .onLongPressGesture {
                                        detailOfPiatto = piatto
                                        let impactHeavy = UIImpactFeedbackGenerator(style: .soft)
                                        impactHeavy.impactOccurred()
                                    }
                                    .sheet(item: $detailOfPiatto) { piatto in
                                        VStack {
                                            Text(piatto.unwrappedNome)
                                                .font(.largeTitle)
                                                .foregroundColor(.primary)
                                            Image(uiImage: piatto.image)
                                                .resizable()
                                                .scaledToFit()
                                                .cornerRadius(10)
                                            Divider()
                                            Text(piatto.unwrappedDescrizione)
                                                .font(.title3)
                                                .foregroundColor(.primary)
                                            Spacer()
                                        }
                                        .padding()
                                    }
                            }
                        }
                    }
                }
            }
            
            
            Button {
                withAnimation {
                    createStep = .confirm
                }
            } label: {
                Text("Prosegui")
                    .font(.largeTitle)
            }
            .buttonStyle(.borderedProminent)
            .padding([.top])
            .disabled(selectedPiatti.isEmpty)
        }
    }
}

//struct OrderMenuRoomView_Previews: PreviewProvider {
//    
//    private static func createRistorante() -> Ristorante {
//        let ristorante = Ristorante(context: PersistenceController.preview.container.viewContext)
//        ristorante.id = 1
//        ristorante.nome = "Ristorante di prova"
//        ristorante.descrizione = "Bel ristorante di prova"
//        
//        return ristorante
//    }
//    
//    static var previews: some View {
//        OrderMenuRoomView(createStep: .constant(.order))
//    }
//}

//
//  ConfirmMenuRoomView.swift
//  Sushime
//
//  Created by Manuel Andruccioli on 25/06/22.
//

import SwiftUI

struct ConfirmMenuRoomView: View {
    
    @Binding var createStep: CreateViewStep
    
    @Binding var selectedPiatti: Dictionary<Piatto, Int>
    @State var detailOfPiatto: Piatto?
    
    var body: some View {
        VStack {
            Text("Conferma Ordine")
                .font(.largeTitle)
            
            List {
                
                ForEach(selectedPiatti.sorted(by: {$0.key.id > $1.key.id}), id: \.key.id) { piatto, quantita in
                    
                    HStack {
                        Text(piatto.unwrappedNome)
                        Spacer()
                        HStack {
                            Button {
                                if (selectedPiatti[piatto] != nil) {
                                    selectedPiatti[piatto]! -= 1
                                    if selectedPiatti[piatto]! <= 0 {
                                        selectedPiatti.removeValue(forKey: piatto)
                                    }
                                }
                            } label: {
                                Image(systemName: "minus.circle")
                            }
                            .buttonStyle(BorderlessButtonStyle())

                            Text(String(quantita))
                            
                            Button {
                                if (selectedPiatti[piatto] != nil) {
                                    selectedPiatti[piatto]! += 1
                                }
                            } label: {
                                Image(systemName: "plus.circle")
                            }
                        }
                    }
                    
                }
                .onDelete { index in
                    let orderedPiatti = selectedPiatti.sorted(by: {$0.key.id > $1.key.id}).map(\.key.id)
                    if let first = index.first {
                        let idToRemove = orderedPiatti[first]
                        selectedPiatti = selectedPiatti.filter { $0.key.id != idToRemove }
                    }
                }
            }
            
            
            HStack {
                Button {
                    withAnimation {
                        createStep = .order
                    }
                } label: {
                    Text("Indietro")
                        .font(.largeTitle)
                }
                .buttonStyle(.borderedProminent)
                .padding([.top])
                
                Button {
                    withAnimation {
                        createStep = .result
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
}

//struct ConfirmMenuRoomView_Previews: PreviewProvider {
//    static var previews: some View {
//        ConfirmMenuRoomView(.constant(.order), selectedPiatti: <#Binding<Set<Piatto>>#>)
//    }
//}

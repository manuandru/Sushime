//
//  ConfirmMenuJoinRoomView.swift
//  Sushime
//
//  Created by Manuel Andruccioli on 26/06/22.
//

import SwiftUI

struct ConfirmMenuJoinRoomView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @Binding var joinStep: JoinViewStep
    
    @Binding var selectedPiatti: Dictionary<Piatto, Int>
    
    @State var isDialogShown = false
    
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
                        joinStep = .order
                    }
                } label: {
                    Text("Indietro")
                        .font(.largeTitle)
                }
                .buttonStyle(.borderedProminent)
                .padding([.top])
                
                Button(role: .destructive) {
                    withAnimation {
                        isDialogShown.toggle()
                    }
                } label: {
                    Text("Termina")
                        .font(.largeTitle)
                }
                .buttonStyle(.borderedProminent)
                .padding([.top])
                .disabled(selectedPiatti.isEmpty)
                .confirmationDialog(
                    "Stai per concludere l'ordine, l'azione è irreversibile",
                    isPresented: $isDialogShown,
                    actions: {
                        Button(role: .destructive) {
                            
                            // TODO: send menu to master
//                            mqtt.generateFinalMenu(from: selectedPiatti)
                            withAnimation {
                                joinStep = .waitResult
                            }
                            
                            
                        } label: {
                            Text("Termina ordine")
                        }
                        Button(role: .cancel) {} label: {
                            Text("Non sono a posto...")
                        }
                    },
                    message: {
                        Text("Stai per concludere l'ordine, l'azione è irreversibile")
                    }
                )
            }
        }
    }
}

//struct ConfirmMenuJoinRoomView_Previews: PreviewProvider {
//    static var previews: some View {
//        ConfirmMenuJoinRoomView()
//    }
//}

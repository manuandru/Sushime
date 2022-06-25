//
//  MergedMenuRoomView.swift
//  Sushime
//
//  Created by Manuel Andruccioli on 25/06/22.
//

import SwiftUI

import SwiftUI

struct MergedMenuRoomView: View {
    
    @EnvironmentObject var mqtt: WrapperMQTT
    @Binding var createStep: CreateViewStep
    
    @FetchRequest(sortDescriptors: [])
    private var piatti: FetchedResults<Piatto>
    
    var body: some View {
        VStack {
            Text("Ordine complessivo")
                .font(.largeTitle)
            List {
                ForEach(mqtt.finalMenu.menu.sorted(by: {$0.key > $1.key}), id: \.key) { piatto, quantita in
                    HStack {
                        Text(piatti.first(where: { $0.id == piatto })?.unwrappedNome ?? "error piatto")
                        Spacer()
                        Text(String(quantita))
                    }
                }
            }
            
        }
    }
}

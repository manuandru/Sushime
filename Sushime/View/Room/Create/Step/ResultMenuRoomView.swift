//
//  ResultMenuRoomView.swift
//  Sushime
//
//  Created by Manuel Andruccioli on 25/06/22.
//

import SwiftUI

struct ResultMenuRoomView: View {
    
    @Binding var createStep: CreateViewStep
    
    @Binding var selectedPiatti: Dictionary<Piatto, Int>
    @State var detailOfPiatto: Piatto?
    
    var body: some View {
        VStack {
            Text("Conferma Ordine")
                .font(.largeTitle)
            
            
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
                        createStep = .mergedMenu
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

//
//  CreateRoomView.swift
//  Sushime
//
//  Created by Manuel Andruccioli on 24/06/22.
//

import SwiftUI
import CocoaMQTT

struct CreatedRoomView: View {

    @EnvironmentObject var appPath: AppPath
    @EnvironmentObject var mqtt: WrapperMQTT
    
    @Binding var createStep: CreateViewStep
    
    var body: some View {
        VStack {
            Spacer()
            Text("La stanza creata\ncon successo ✅")
                .font(.largeTitle)
            
            Text("Condividi il codice con i tuoi amici")
                .font(.title3)
            
            Spacer()
            
            Button {
                withAnimation {

                }
            } label: {
                Text("Prosegui")
                    .font(.largeTitle)
            }
            .buttonStyle(.borderedProminent)
        }
        .onAppear {
            mqtt.clientMQTT.subscribe("\(appPath.tableId)/#")
        }
    }
}

//struct CreatedRoomView_Previews: PreviewProvider {
//    static var previews: some View {
//        CreatedRoomView(createStep: .constant(.created))
//    }
//}

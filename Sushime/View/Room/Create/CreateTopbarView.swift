//
//  TopbarView.swift
//  Sushime
//
//  Created by Manuel Andruccioli on 23/06/22.
//

import SwiftUI

struct CreateTopbarView: View {
    
    @EnvironmentObject var appPath: AppPath
    @EnvironmentObject var mqtt: WrapperMQTT
    
    @Binding var activeSheet: ActiveSheet?
    
    @State var presentExitAlert = false
    @State var isQRCodeShown = false
    @State var isMemberListShown = false
    
    var body: some View {
        HStack {
            Button(role: .destructive) {
                presentExitAlert = true
            } label: {
                Image(systemName: "xmark")
                    .resizable()
                    .frame(width: 35, height: 35)
            }
            .confirmationDialog(
                "Questa stanza verrà eliminata. L'azione è irreversibile",
                isPresented: $presentExitAlert,
                actions: {
                    Button(role: .destructive) {
                        activeSheet = .none
                    } label: {
                        Text("Elimina stanza")
                    }
                    Button(role: .cancel) {} label: {
                        Text("Annulla")
                    }
                },
                message: {
                    Text("Questa stanza verrà eliminata. L'azione è irreversibile")
                }
            )
            
            Spacer()
            
            Image(systemName: "person.3.fill")
                .resizable()
                .frame(width: 75, height: 35)
                .onTapGesture {
                    isMemberListShown.toggle()
                }
                
            
            Spacer()
            
            Button {
                isQRCodeShown.toggle()
            } label: {
                Image(systemName: "qrcode")
                    .resizable()
                    .frame(width: 35, height: 35)
            }
        }
        .sheet(isPresented: $isQRCodeShown) {
            QRCodeView()
        }
        .sheet(isPresented: $isMemberListShown) {
            VStack {
                Text("Partecipanti")
                    .font(.largeTitle)
                List {
                    ForEach(mqtt.creationState.users, id: \.self) { user in
                        Text(user)
                            .font(.title3)
                    }
                }
                Spacer()
            }
            .padding()
            .ignoresSafeArea()
        }
    }
}

struct TopbarView_Previews: PreviewProvider {
    static var previews: some View {
        CreateTopbarView(activeSheet: .constant(.create))
    }
}

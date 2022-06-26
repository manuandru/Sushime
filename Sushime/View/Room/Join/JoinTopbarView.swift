//
//  JoinTopbarView.swift
//  Sushime
//
//  Created by Manuel Andruccioli on 25/06/22.
//

import SwiftUI

struct JoinTopbarView: View {
    
    @EnvironmentObject var appPath: AppPath
    @EnvironmentObject var mqtt: WrapperMQTTClient
    
    @Binding var activeSheet: ActiveSheet?
    @State var presentExitAlert = false
    
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
                "Uscirai dalla stanza. L'azione è irreversibile",
                isPresented: $presentExitAlert,
                actions: {
                    Button(role: .destructive) {
                        withAnimation {
                            activeSheet = .none
                            mqtt.unsubscribeFrom()
                        }
                    } label: {
                        Text("Elimina stanza")
                    }
                    Button(role: .cancel) {} label: {
                        Text("Annulla")
                    }
                },
                message: {
                    Text("Uscirai dalla stanza. L'azione è irreversibile")
                }
            )
            
            Spacer()
            
            Text("Stanza: \(appPath.tableId)")
        }
    }
}

struct JoinTopbarView_Previews: PreviewProvider {
    static var previews: some View {
        JoinTopbarView(activeSheet: .constant(.join))
    }
}

//
//  TopbarView.swift
//  Sushime
//
//  Created by Manuel Andruccioli on 23/06/22.
//

import SwiftUI

struct CreateTopbarView: View {
    
    @EnvironmentObject var appPath: AppPath
    
    @Binding var activeSheet: ActiveSheet?
    
    @State var presentExitAlert = false
    @State var isQRCodeShown = false
    
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
    }
}

struct TopbarView_Previews: PreviewProvider {
    static var previews: some View {
        CreateTopbarView(activeSheet: .constant(.create))
    }
}

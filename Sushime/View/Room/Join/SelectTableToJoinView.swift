//
//  SelectTableToJoinView.swift
//  Sushime
//
//  Created by Manuel Andruccioli on 25/06/22.
//

import SwiftUI

struct SelectTableToJoinView: View {
    @Binding var activeSheet: ActiveSheet?
    @EnvironmentObject var appPath: AppPath

    var body: some View {
        VStack {
            
            HStack {
                Button {
                    withAnimation {
                        activeSheet = .none
                    }
                } label: {
                    Image(systemName: "xmark")
                        .resizable()
                        .scaledToFit()
                }
                
                Spacer()
            }
            .frame(height: 20)
            .padding()
            
            Spacer()
            
            Text("Inserisci il codice")
                .font(.largeTitle)
                .padding()
            
            TextField("Codice", text: $appPath.tableId)
                .font(.largeTitle)
                .padding()
                .background(.quaternary)
                .cornerRadius(15)
                .textInputAutocapitalization(.never)
            
            Button {
                withAnimation {
                    activeSheet = .join
                }
            } label: {
                Text("Partecipa")
                    .font(.largeTitle)
            }
            .buttonStyle(.borderedProminent)
            .padding()
            
            
            Spacer()
        }
        .padding()
    }
}

struct SelectTableToJoinView_Previews: PreviewProvider {
    static var previews: some View {
        SelectTableToJoinView(activeSheet: .constant(.selectingTable))
            .environmentObject(AppPath())
    }
}

//
//  RoomView.swift
//  Sushime
//
//  Created by Manuel Andruccioli on 19/06/22.
//

import SwiftUI

struct RoomView: View {
    @EnvironmentObject var appPath: AppPath
    
    var body: some View {
        VStack(alignment: .center) {
            Text("Room")
                .font(.largeTitle)
                
            Spacer()
            
            SelectionButton(action: {
                
            }, content: "Create\nRoom", image: "plus.circle", color: .systemGreen)
            
            SelectionButton(action: {
                appPath.presentJoin = true
            }, content: "Join\nRoom", image: "person.badge.plus", color: .systemCyan)

            Spacer()
        }.padding()
            .sheet(isPresented: $appPath.presentJoin) {
                Form {
                    TextField("OK", text: $appPath.tableId)
                }
            }
            .sheet(isPresented: $appPath.presentCreate) {
                VStack {
                    Text("Crea")
                        .font(.largeTitle)
                }
            }
    }
}

struct RoomView_Previews: PreviewProvider {
    static var previews: some View {
        RoomView()
            .previewInterfaceOrientation(.portrait)
    }
}

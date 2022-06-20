//
//  RoomView.swift
//  Sushime
//
//  Created by Manuel Andruccioli on 19/06/22.
//

import SwiftUI

struct RoomView: View {
    var body: some View {
        VStack(alignment: .center) {
            Text("Room")
                .font(.largeTitle)
                
            Spacer()
            
            SelectionButton(action: {
                
            }, content: "Create\nRoom", image: "plus.circle", color: .systemGreen)
            
            SelectionButton(action: {
                
            }, content: "Join\nRoom", image: "person.badge.plus", color: .systemCyan)

            Spacer()
        }.padding()
    }
}

struct RoomView_Previews: PreviewProvider {
    static var previews: some View {
        RoomView()
            .previewInterfaceOrientation(.portrait)
    }
}

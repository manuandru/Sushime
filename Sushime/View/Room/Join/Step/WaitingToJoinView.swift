//
//  WaitingToJoinView.swift
//  Sushime
//
//  Created by Manuel Andruccioli on 26/06/22.
//

import SwiftUI

struct WaitingToJoinView: View {
    
    @EnvironmentObject var mqtt: WrapperMQTTClient
    
    var body: some View {
        VStack {
            Spacer()
            Text("\(mqtt.status.description)")
                .font(.title3)
                .padding()
            ProgressView()
                .scaleEffect(1.5)
            Spacer()
        }
    }
}

struct WaitingToJoinView_Previews: PreviewProvider {
    static var previews: some View {
        WaitingToJoinView()
    }
}

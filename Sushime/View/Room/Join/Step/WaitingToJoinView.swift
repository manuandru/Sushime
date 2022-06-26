//
//  WaitingToJoinView.swift
//  Sushime
//
//  Created by Manuel Andruccioli on 26/06/22.
//

import SwiftUI

struct WaitingToJoinView: View {
    var body: some View {
        ProgressView()
            .scaleEffect(1.5)
    }
}

struct WaitingToJoinView_Previews: PreviewProvider {
    static var previews: some View {
        WaitingToJoinView()
    }
}

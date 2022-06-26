//
//  JoinTopbarView.swift
//  Sushime
//
//  Created by Manuel Andruccioli on 25/06/22.
//

import SwiftUI

struct JoinTopbarView: View {
    
    @Binding var activeSheet: ActiveSheet?
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct JoinTopbarView_Previews: PreviewProvider {
    static var previews: some View {
        JoinTopbarView(activeSheet: .constant(.join))
    }
}

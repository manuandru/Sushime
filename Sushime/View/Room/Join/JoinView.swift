//
//  JoinView.swift
//  Sushime
//
//  Created by Manuel Andruccioli on 23/06/22.
//

import SwiftUI

struct JoinView: View {
    
    @Binding var activeSheet: ActiveSheet?
    
    var body: some View {
        VStack {
            
        }
    }
}

struct JoinView_Previews: PreviewProvider {
    static var previews: some View {
        JoinView(activeSheet: .constant(.join))
    }
}

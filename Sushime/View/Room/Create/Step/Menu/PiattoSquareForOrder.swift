//
//  PiattoSquareForOrder.swift
//  Sushime
//
//  Created by Manuel Andruccioli on 25/06/22.
//

import SwiftUI

struct PiattoSquareForOrder: View {
    var piatto: Piatto
    
    @State var presentDetail: Bool = false
    
    var backgroundColor: UIColor
    
    var body: some View {
        ZStack {
            Color(uiColor: backgroundColor)
            VStack {
                Text(piatto.unwrappedNome)
                    .lineLimit(1)
                    .foregroundColor(.primary)
                    .font(.title2)
                Image(uiImage: piatto.image)
                    .resizable()
                    .cornerRadius(5)
                    .scaledToFit()
                    .shadow(radius: 5)
            }
            .padding()
        }
        .frame(width: 150, height: 150, alignment: .center)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}

struct PiattoSquareForOrder_Previews: PreviewProvider {
    private static func createPiatto() -> Piatto {
        let piatto = Piatto(context: PersistenceController.preview.container.viewContext)
        piatto.id = 1
        piatto.nome = "Ristorante di prova"
        piatto.descrizione = "Bel ristorante di prova"
        
        return piatto
    }
    
    static var previews: some View {
        Group {
            PiattoSquareForOrder(piatto: createPiatto(), backgroundColor: .systemFill)
            PiattoSquareForOrder(piatto: createPiatto(), backgroundColor: .systemGreen)
                .preferredColorScheme(.dark)
        }
    }
}

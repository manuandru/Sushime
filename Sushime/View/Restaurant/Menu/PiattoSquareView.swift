//
//  PiattoSquareView.swift
//  Sushime
//
//  Created by Manuel Andruccioli on 23/06/22.
//

import SwiftUI

struct PiattoSquareView: View {
    
    var piatto: Piatto
    
    @State var presentDetail: Bool = false
    
    var body: some View {
        Button {
            presentDetail.toggle()
        } label: {
            ZStack {
                Color(uiColor: .systemFill)
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
        }
        .frame(width: 150, height: 150, alignment: .center)
        .cornerRadius(10)
        .sheet(isPresented: $presentDetail) {
            VStack {
                Text(piatto.unwrappedNome)
                    .font(.largeTitle)
                    .foregroundColor(.primary)
                Image(uiImage: piatto.image)
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(10)
                Divider()
                Text(piatto.unwrappedDescrizione)
                    .font(.title3)
                    .foregroundColor(.primary)
                Spacer()
            }
            .padding()
        }
        .shadow(radius: 5)
    }
}

struct PiattoSquareView_Previews: PreviewProvider {
    
    private static func createPiatto() -> Piatto {
        let piatto = Piatto(context: PersistenceController.preview.container.viewContext)
        piatto.id = 1
        piatto.nome = "Ristorante di prova"
        piatto.descrizione = "Bel ristorante di prova"
        
        return piatto
    }
    
    static var previews: some View {
        Group {
            PiattoSquareView(piatto: createPiatto())
            PiattoSquareView(piatto: createPiatto())
                .preferredColorScheme(.dark)
        }
    }
    
}

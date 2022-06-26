//
//  SplashScreenView.swift
//  Sushime
//
//  Created by Manuel Andruccioli on 19/06/22.
//

import SwiftUI
import CoreData

struct SplashScreenView: View {
    @State var splashScreen = true
    @Environment(\.managedObjectContext) private var viewContext
    
    
    @FetchRequest(sortDescriptors: [])
    private var piatti: FetchedResults<Piatto>
    
    @FetchRequest(sortDescriptors: [])
    private var ristoranti: FetchedResults<Ristorante>
    
    @FetchRequest(sortDescriptors: [])
    private var categorie: FetchedResults<Categoria>
    
    @FetchRequest(sortDescriptors: [])
    private var piattiInOrdine: FetchedResults<PiattoInOrdine>

    @FetchRequest(sortDescriptors: [])
    private var ordini: FetchedResults<Ordine>
    
    
    
    var body: some View {
        VStack {
            if splashScreen {
                Image("sushime-logo-no-bg")
                    .resizable()
                    .frame(width: 125, height: 125, alignment: .center)
                    .transition(.scale(scale: 4))
            } else {
                RootView()
            }
        }
        .onAppear {
            
            if piatti.count == 0 || ristoranti.count == 0 || categorie.count == 0 {
                PersistenceController.fetchPresetData(with: viewContext)
            }
            
            // TO Delete all entries
//            piatti.map({viewContext.delete($0)})
//            ristoranti.map({viewContext.delete($0)})
//            categorie.map({viewContext.delete($0)})
//            piattiInOrdine.map({viewContext.delete($0)})
//            ordini.map({viewContext.delete($0)})
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                withAnimation {
                    self.splashScreen = false
                }
            }
        }
    }
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}

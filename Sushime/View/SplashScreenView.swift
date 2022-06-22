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
            PersistenceController.fetchPresetData(with: viewContext)
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

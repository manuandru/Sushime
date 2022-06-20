//
//  SushimeApp.swift
//  Sushime
//
//  Created by Manuel Andruccioli on 04/06/22.
//

import SwiftUI

@main
struct SushimeApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
//            ContentView()
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
            SplashScreenView()
        }
    }
}

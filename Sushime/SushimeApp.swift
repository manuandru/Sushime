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
    
    @StateObject var appPath = AppPath()

    var body: some Scene {
        WindowGroup {
//            ContentView()
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
            SplashScreenView()
                .environmentObject(appPath)
                .onOpenURL { url in
                    if let tableId = url.host {
                        appPath.tab = .room
                        appPath.presentJoin = true
                        appPath.tableId = tableId
                    }
                }
        }
    }
}

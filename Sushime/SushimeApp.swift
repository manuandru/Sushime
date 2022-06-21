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
    
    // For handle home shortcut
    @UIApplicationDelegateAdaptor private var appDelegate: AppDelegate

    var body: some Scene {
        WindowGroup {
//            ContentView()
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
            SplashScreenView()
                .environmentObject(appPath)
                .onOpenURL { url in
                    appPath.restore()
                    if let command = url.host {
                        switch command {
                        case "create":
                            appPath.tab = .room
                            appPath.presentCreate = true
                            break

                        case "table":
                            appPath.tab = .room
                            appPath.presentJoin = true
                            appPath.tableId = url.lastPathComponent
                            break
                        default: break

                        }
                    }
                }
        }
    }
}

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
    @StateObject var mqttWrapper = WrapperMQTT()
    
    // To handle home shortcut
    @UIApplicationDelegateAdaptor private var appDelegate: AppDelegate

    var body: some Scene {
        WindowGroup {
//            ContentView()
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
            SplashScreenView()
                .environmentObject(appPath)
                .environmentObject(mqttWrapper)
                .onOpenURL { url in
                    appPath.restore()
                    if let command = url.host {
                        switch command {
                        case "create":
                            appPath.tab = .room
                            appPath.activeSheet = .selectingRestaurantToCreate
                            break

                        case "table":
                            appPath.tab = .room
                            appPath.activeSheet = .join
                            appPath.tableId = url.lastPathComponent
                            break
                        default: break

                        }
                    }
                }
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

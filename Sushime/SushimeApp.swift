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
    
    // To handle home shortcut
    @UIApplicationDelegateAdaptor private var appDelegate: AppDelegate
    
    static let MQTTBrokerIp = "broker.emqx.io"//"7.tcp.eu.ngrok.io"
    static let MQTTBrokerPort = 1883

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

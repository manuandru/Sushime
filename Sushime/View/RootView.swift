//
//  RootView.swift
//  Sushime
//
//  Created by Manuel Andruccioli on 04/06/22.
//

import SwiftUI

struct RootView: View {
    @EnvironmentObject var appPath: AppPath
    @AppStorage("name") var name: String = ""
    @AppStorage("surname") var surname: String = ""
    @AppStorage("username") var username: String = ""
    
    var body: some View {
        TabView(selection: $appPath.tab) {
            RestaurantView()
                .tabItem {
                    Label("Ristoranti", systemImage: "list.bullet.circle.fill")
                }
                .tag(AppTab.restaurant)
            RoomView()
                .tabItem {
                    Label("Stanza", systemImage: "person.3.fill")
                }
                .tag(AppTab.room)
            AccountView()
                .tabItem {
                    Label("Account", systemImage: "person.crop.circle.fill")
                }
                .tag(AppTab.account)
                .badge(needBadge() ? "!" : nil)
        }
    }
    
    func needBadge() -> Bool {
        name == "" || surname == "" || username == ""
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}

//
//  RootView.swift
//  Sushime
//
//  Created by Manuel Andruccioli on 04/06/22.
//

import SwiftUI

struct RootView: View {
    @EnvironmentObject var appPath: AppPath
    
    var body: some View {
        TabView(selection: $appPath.tab) {
            RestaurantView()
                .tabItem {
                    Label("Ristoranti", systemImage: "list.bullet.circle.fill")
                }
                .tag(AppTab.restaurant)
            RoomView()
                .tabItem {
                    Label("Room", systemImage: "person.3.fill")
                }
                .tag(AppTab.room)
            AccountView()
                .tabItem {
                    Label("Account", systemImage: "person.crop.circle.fill")
                }
                .tag(AppTab.account)
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}

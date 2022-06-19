//
//  RootView.swift
//  Sushime
//
//  Created by Manuel Andruccioli on 04/06/22.
//

import SwiftUI

struct RootView: View {
    var body: some View {
        TabView {
            RestaurantView()
                .tabItem {
                    Label("Ristoranti", systemImage: "list.bullet.circle.fill")
                }
            RoomView()
                .tabItem {
                    Label("Room", systemImage: "person.3.fill")
                }
            AccountView()
                .tabItem {
                    Label("Account", systemImage: "person.crop.circle.fill")
                }
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}

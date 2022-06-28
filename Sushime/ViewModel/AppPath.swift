//
//  AppPath.swift
//  Sushime
//
//  Created by Manuel Andruccioli on 21/06/22.
//

import Foundation
import CocoaMQTT

class AppPath: ObservableObject {
    
    @Published var tab: AppTab = .restaurant
    @Published var activeSheet: ActiveSheet?
    @Published var tableId: String = ""
    @Published var joinedRestaurant: Ristorante?
    
    
    func createTable() {
        generateRandomRoom()
    }
    
    func linkToShare() -> String {
        "sushime://table/\(tableId)"
    }
    
    func restore() {
        tab = .restaurant
        activeSheet = .none
        tableId = ""
    }
    
    private func generateRandomRoom() {
        let letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        tableId = String((0..<5).map{ _ in letters.randomElement()! })
//        tableId = "123"
    }
}

enum AppTab: Hashable {
    case restaurant
    case room
    case account
}

enum ActiveSheet: String, Identifiable {
    case join, create, selectingRestaurantToCreate, selectingTable, scanner
    
    var id: String {
        return self.rawValue
    }
}

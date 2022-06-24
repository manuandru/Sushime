//
//  AppPath.swift
//  Sushime
//
//  Created by Manuel Andruccioli on 21/06/22.
//

import Foundation

class AppPath: ObservableObject {
    
    @Published var tab: AppTab = .restaurant
    @Published var activeSheet: ActiveSheet?
    @Published var tableId: String = ""
    
    func linkToShare() -> String {
        "sushime://table/\(tableId)"
    }
    
    func restore() {
        tab = .restaurant
        activeSheet = .none
        tableId = ""
    }
    
    func generateRandomRoom() {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        tableId = String((0..<8).map{ _ in letters.randomElement()! })
    }
}

enum AppTab: Hashable {
    case restaurant
    case room
    case account
}

enum ActiveSheet: String, Identifiable {
    case join, create, scanner
    
    var id: String {
        return self.rawValue
    }
}

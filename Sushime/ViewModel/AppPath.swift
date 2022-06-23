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
    
    func restore() {
        tab = .restaurant
        activeSheet = .none
        tableId = ""
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

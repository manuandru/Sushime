//
//  AppPath.swift
//  Sushime
//
//  Created by Manuel Andruccioli on 21/06/22.
//

import Foundation

class AppPath: ObservableObject {
    
    @Published var tab: AppTab = .restaurant
    @Published var presentJoin: Bool = false
    @Published var presentCreate: Bool = false
    @Published var tableId: String = ""
    
    func restore() {
        tab = .restaurant
        presentJoin = false
        presentCreate = false
        tableId = ""
    }
}

enum AppTab: Hashable {
    case restaurant
    case room
    case account
}

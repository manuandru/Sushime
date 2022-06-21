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
    @Published var tableId: String = ""
}

enum AppTab: Hashable {
    case restaurant
    case room
    case account
}

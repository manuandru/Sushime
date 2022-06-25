//
//  CreationState.swift
//  Sushime
//
//  Created by Manuel Andruccioli on 24/06/22.
//

import Foundation

struct CreationState {
    
    var users: [UserFromNetwork] = []
}

struct UserFromNetwork: Hashable {
    static func == (lhs: UserFromNetwork, rhs: UserFromNetwork) -> Bool {
        lhs.name == rhs.name
    }
    
    var orders: Dictionary<Int, Int>
    
    var name: String
}

//
//  DBExtension.swift
//  Sushime
//
//  Created by Manuel Andruccioli on 22/06/22.
//

import Foundation


extension Categoria {
    public var piattiArray: Array<Piatto> {
        let set = self.piatti as? Set<Piatto> ?? []
        
        return set.sorted(by: {
            $0.id > $1.id
        })
    }
}

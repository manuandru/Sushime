//
//  DBExtension.swift
//  Sushime
//
//  Created by Manuel Andruccioli on 22/06/22.
//

import Foundation
import UIKit


extension Categoria {
    public var piattiArray: Array<Piatto> {
        let set = self.piatti as? Set<Piatto> ?? []
        
        return set.sorted(by: {
            $0.id > $1.id
        })
    }
    
    public var unwrappedNome: String {
        self.nome ?? "error Ristorante"
    }
}

extension Ordine {
    public var piattiArray: Array<PiattoInOrdine> {
        let set = self.inPiattoOrdine as? Set<PiattoInOrdine> ?? []
        
        return set.sorted(by: {
            $0.id > $1.id
        })
    }
}

extension Ristorante {
    public var unwrappedNome: String {
        self.nome ?? "error Ristorante"
    }
    
    public var unwrappedDescrizione: String {
        self.descrizione ?? "error Ristorante"
    }
    
    public var image: UIImage {
        var img: UIImage?
        if let imagePath = Bundle.main.path(forResource: "restaurant-img/\(String(self.id))", ofType: "jpg") {
            img = UIImage(contentsOfFile: imagePath)
        }
        return img ?? UIImage(systemName: "person")!
    }
}

extension Piatto {
    public var unwrappedNome: String {
        self.nome ?? "error Piatto"
    }
    
    public var unwrappedDescrizione: String {
        self.descrizione ?? "error Piatto"
    }
    
    public var image: UIImage {
        var img: UIImage?
        if let imagePath = Bundle.main.path(forResource: "sushi-img/\(String(self.id))", ofType: "jpg") {
            img = UIImage(contentsOfFile: imagePath)
        }
        return img ?? UIImage(systemName: "person")!
    }
}

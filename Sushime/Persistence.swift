//
//  Persistence.swift
//  Sushime
//
//  Created by Manuel Andruccioli on 04/06/22.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        
        let newRist = Ristorante(context: viewContext)
        newRist.id = 1
        newRist.nome = "prova"
        newRist.descrizione = "bella descr"
        try? viewContext.save()
        
        for _ in 0..<10 {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()
        }
        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "Sushime")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.

                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
    
    
    static func fetchPresetData(with context: NSManagedObjectContext) {
        
//        let newCat1 = Categorie(context: context)
//        newCat1.id = 1
//        newCat1.nome = "Antipasti"
//        try? context.save()
//
//        let newCat2 = Categorie(context: context)
//        newCat2.id = 3
//        newCat2.nome = "Zuppa"
//        try? context.save()
//
//        print(context)
        
        // TODO: salvare i dati
        
        var categories = [Categoria]()
        if let pathCategorie = Bundle.main.path(forResource: "categorie", ofType: "csv") {
            do {
                let entries = try String(contentsOfFile: pathCategorie, encoding: .utf8)
                for row in entries.split(separator: "\r\n") {
                    let data = row.split(separator: ";")
                    if let id = Int(data[0]) {
                        let newCategoria = Categoria(context: context)
                        newCategoria.id = Int32(id)
                        newCategoria.nome = String(data[1])
                        categories.append(newCategoria)
                    }
                }
            } catch let error {
                print(error)
            }
        }
        
        
        var piatti = [Piatto]()
        if let pathPiatti = Bundle.main.path(forResource: "piatti", ofType: "csv") {
            do {
                let entries = try String(contentsOfFile: pathPiatti, encoding: .utf8)
                for row in entries.split(separator: "\r\n") {
                    let data = row.split(separator: ";")
                    if let id = Int(data[0]) {
                        let newPiatto = Piatto(context: context)
                        newPiatto.id = Int32(id)
                        newPiatto.nome = String(data[1])
                        newPiatto.descrizione = String(data[2])
                        newPiatto.categoria = categories.first(where: { $0.id == Int32(data[3]) })
                        piatti.append(newPiatto)
                    }
                }
            } catch let error {
                print(error)
            }
        }
        
        var ristoranti = [Ristorante]()
        if let pathRistoranti = Bundle.main.path(forResource: "ristoranti", ofType: "csv") {
            do {
                let entries = try String(contentsOfFile: pathRistoranti, encoding: .utf8)
                for row in entries.split(separator: "\r\n") {
                    let data = row.split(separator: ";")
                    if let id = Int(data[0]) {
                        let newRistorante = Ristorante(context: context)
                        newRistorante.id = Int32(id)
                        newRistorante.nome = String(data[1])
                        newRistorante.descrizione = String(data[2])
                        ristoranti.append(newRistorante)
                    }
                }
            } catch let error {
                print(error)
            }
        }
        
    }
}

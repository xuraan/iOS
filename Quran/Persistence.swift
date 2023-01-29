//
//  Persistence.swift
//  Quran
//
//  Created by Samba Diawara on 2023-01-27.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        let newPlace = Place(context: viewContext)
        newPlace.id = "mk"
        let newPlace1 = Place(context: viewContext)
        newPlace1.id = "md"

        
        let suras = Bundle.main.decodeQuran("quran.json")
        var sofhaId: Int16 = 1
        var newSofha = Sofha(context: viewContext)
        newSofha.id = sofhaId
        for sura in suras {
            let newSura = Sura(context: viewContext)
            newSura.id = Int16(sura.id)
            newSura.name = sura.name
            newSura.phonetic = sura.phonetic
            newSura.place = sura.place == "mk" ? newPlace : newPlace1
            var surasSofha = Set<Sofha>()
            for aya in sura.ayas{
                let newAya = Aya(context: viewContext)
                newAya.id = aya.id
                newAya.text = aya.text
                newAya.plain = aya.plain
                newAya.sura = newSura
                
                surasSofha.insert(newSofha)
                if aya.sofha == sofhaId {
                    newAya.sofha = newSofha
                } else {
                    sofhaId = sofhaId + 1
                    newSofha = Sofha(context: viewContext)
                    newSofha.id = sofhaId
                    newAya.sofha = newSofha
                }
            }
            for sofha in surasSofha {
                newSura.addToSofhas(sofha)
            }
        
        }
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "Quran")
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
}

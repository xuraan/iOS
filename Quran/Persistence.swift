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
                
                newSura.addToSofhas(newSofha)
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
                ErrorHandler.shared.handle(error)
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
        let viewContext = container.viewContext
        if !UserDefaults.standard.bool(forKey: "dataWasAdded"){
            do {
                //MARK: - App Kollection
                let favorite = Kollection(context: viewContext)
                favorite.id = "C6819E4A-9203-48CE-9EE4-AAF815B52D09"
                favorite.colorHex = "FF0000"

                //MARK: - Quran
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
                    newSofha.kollections = .init()
                    var surasSofha = Set<Sofha>()
                    for aya in sura.ayas{
                        let newAya = Aya(context: viewContext)
                        newAya.id = aya.id
                        newAya.text = aya.text
                        newAya.plain = aya.plain
                        newAya.sura = newSura
                        newAya.kollections = .init()
                        if aya.sofha == sofhaId {
                            newAya.sofha = newSofha
                            surasSofha.insert(newSofha)

                        } else {
                            sofhaId = sofhaId + 1
                            newSofha = Sofha(context: viewContext)
                            newSofha.id = sofhaId
                            newAya.sofha = newSofha
                            surasSofha.insert(newSofha)
                        }
                    }
                    for sofha in surasSofha.sorted(by: { $0.id < $1.id }) {
                        newSura.addToSofhas(sofha)
                        newSofha.kollections = .init()
                    }
                }
                try viewContext.save()
                UserDefaults.standard.set(true, forKey: "dataWasAdded")
            } catch let error {
                ErrorHandler.shared.handle(error)
            }
        }
    }
}

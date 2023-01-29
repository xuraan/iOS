//
//  QuranApp.swift
//  Quran
//
//  Created by Samba Diawara on 2023-01-27.
//

import SwiftUI

@main
struct QuranApp: App {
    @Environment(\.scenePhase) var scenePhase
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onChange(of: scenePhase){ phase in
                    if phase == .background {
                        try? persistenceController.container.viewContext.save()
                    }
                }
                .onAppear{
                    if !UserDefaults.standard.bool(forKey: "dataWasAdded"){
                        let viewContext = persistenceController.container.viewContext
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
                        try? viewContext.save()
                        UserDefaults.standard.set(true, forKey: "dataWasAdded")
                    }
                }
                .environment(\.managedObjectContext, persistenceController.container.viewContext)

        }
    }
}

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
                    if phase != .active {
                        do{
                            try persistenceController.container.viewContext.save()
                        } catch let error {
                            ErrorHandler.shared.handle(error)
                        }
                    }
                }
                .onDisappear{
                    do{
                        try persistenceController.container.viewContext.save()
                    } catch let error {
                        ErrorHandler.shared.handle(error)
                    }
                }
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

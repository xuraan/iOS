//
//  fyucxfyhcgjvhkblnk_App.swift
//  fyucxfyhcgjvhkblnk;
//
//  Created by Samba Diawara on 2023-02-02.
//

import SwiftUI

@main
struct fyucxfyhcgjvhkblnk_App: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

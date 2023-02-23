//
//  QuranApp.swift
//  Quran
//
//  Created by Samba Diawara on 2023-01-27.
//

import SwiftUI

@main
struct QuranApp: App {
    @StateObject var model: Model = .init()
    @StateObject var qModel: QuranViewModel = .init()
    @StateObject var kModel: KollectionProvider = .init()
    @Environment(\.scenePhase) var scenePhase
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onChange(of: scenePhase, perform: { phase in
                    if phase != .active {
                        KollectionProvider.save(data: kModel.kollections)
                        KollectionProvider.save(data: KollectionProvider.favorite, in: "favorite.data")
                    }
                })

                .environmentObject(model)
                .environmentObject(qModel)
                .environmentObject(kModel)
                .preferredColorScheme(model.preferredColorScheme)
        }
    }
}

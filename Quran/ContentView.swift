//
//  ContentView.swift
//  Quran
//
//  Created by Samba Diawara on 2023-01-27.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @StateObject var model: Model = .init()
    @StateObject var quranVM: QuranViewModel = .init()
    @StateObject var suraVM: SuraViewModel = .init()
    @StateObject var searchVM: SearchModel = .init()
    @StateObject var ayaVM: AyaViewModel = .init()

    var body: some View {
        GeometryReader{ proxy in
            MainView()
        }
        
        //MARK: - ENVIRONMENTS OBJECT
        .environmentObject(model)
        .environmentObject(quranVM)
        .environmentObject(suraVM)
        .environmentObject(searchVM)
        .environmentObject(ayaVM)
        
        //MARK: -THEME
        .preferredColorScheme(model.preferredColorScheme)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}

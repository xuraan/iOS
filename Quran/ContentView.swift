//
//  ContentView.swift
//  Quran
//
//  Created by Samba Diawara on 2023-01-27.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) var viewContext
    @FetchRequest var favorite: FetchedResults<Kollection>

    @StateObject var model: Model = .init()
    @StateObject var quranVM: QuranViewModel = .init()
    @StateObject var suraVM: SuraViewModel = .init()
    @StateObject var searchVM: SearchModel = .init()
    @StateObject var ayaVM: AyaViewModel = .init()
    init(){
        _favorite = Kollection.favorite
    }
    var body: some View {
        
        GeometryReader{ proxy in
            MainView()
                .environment(\.safeArea, proxy.safeAreaInsets)
        }
        
        //MARK: - ENVIRONMENTS OBJECT
        .environmentObject(model)
        .environmentObject(quranVM)
        .environmentObject(suraVM)
        .environmentObject(searchVM)
        .environmentObject(ayaVM)
        .environment(\.favorite, favorite.first!)
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

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
                .environment(\.safeArea, proxy.safeAreaInsets)
        }
        .preferredColorScheme(model.preferredColorScheme)
        .environmentObject(model)
        .environmentObject(quranVM)
        .environmentObject(suraVM)
        .environmentObject(searchVM)
        .environmentObject(ayaVM)
        .onAppear{
            let familyNames = UIFont.familyNames

            for family in familyNames {
                print("Family name " + family)
                let fontNames = UIFont.fontNames(forFamilyName: family)
                
                for font in fontNames {
                    print("    Font name: " + font)
                }
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}

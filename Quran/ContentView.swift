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
    @State var pinned: Any? = nil
    init(){
        _favorite = Kollection.request(for: "C6819E4A-9203-48CE-9EE4-AAF815B52D09")
    }
    var body: some View {
        MainView()
        //MARK: - ENVIRONMENTS OBJECT
        .environmentObject(model)
        .environmentObject(quranVM)
        .environmentObject(suraVM)
        .environmentObject(searchVM)
        .environmentObject(ayaVM)
        .environment(\.favorite, favorite.first)
        .environment(\.pinned, $pinned)
        .alert("Error", isPresented: .constant(!ErrorHandler.shared.errorMessage.isEmpty), actions: {
            Button(role: .cancel, action: {ErrorHandler.shared.errorMessage = ""}, label:{Text("OK")})
        }, message: {
            Text(ErrorHandler.shared.errorMessage)
        })
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

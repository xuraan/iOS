//
//  ContentView.swift
//  Quran
//
//  Created by Samba Diawara on 2023-01-27.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @FetchRequest(sortDescriptors: [SortDescriptor(\.id)]) var suras: FetchedResults<Sura>
    @FetchRequest(sortDescriptors: [SortDescriptor(\.id)]) var ayas: FetchedResults<Sura>
    @FetchRequest(sortDescriptors: [SortDescriptor(\.id)]) var sofhas: FetchedResults<Sofha>

    @StateObject var quranVM: QuranViewModel = .init()
    @StateObject var suraVM: SuraViewModel = .init()
    @StateObject var searchVM: SearchModel = .init()
    @StateObject var ayaVM: AyaViewModel = .init()
    @State var searchText = ""
    
    @State var selectedDetent: PresentationDetent = .medium
    var body: some View {
        Container(selectedDetent: $selectedDetent, isCover: $quranVM.isShow, showSheet: $quranVM.isShowIndex, content: {
            NavigationStack{
                HomeView(text: $searchText)
                .scrollContentBackground(.hidden)
                .background(Color("bg"))
                .toolbar{
                    ToolbarItem(placement: .navigationBarLeading){
                        NavigationLink("Settings"){
                            SettingsView()
                        }
                    }
                    ToolbarItem(placement: .navigationBarTrailing){
                        Menu("Actions"){
                            Button(action: {}, label: {
                                Label("Collection", systemImage: "plus")
                            })
                        }
                    }
                    
                }
            }
            .searchable(text: $searchText, tokens: $searchVM.tokens, token: { token in
                switch token {
                case .sura: Text("sura")
                case .aya: Text("aya")
                case .sofha: Text("sofha")
                }
            })
        }, sheet: {
            QuranIndexView(
                suras: suras.map{$0},
                sofhas: sofhas.map{$0},
                selectedDetent: $selectedDetent
            )
                .environmentObject(quranVM)
                .environmentObject(suraVM)
        }, overlay: {
            QuranView()
        })
        
        
        .environmentObject(quranVM)
        .environmentObject(suraVM)
        .environmentObject(searchVM)
        .environmentObject(ayaVM)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}

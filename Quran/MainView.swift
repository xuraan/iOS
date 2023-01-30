//
//  MainView.swift
//  Quran
//
//  Created by Samba Diawara on 2023-01-29.
//

import SwiftUI

struct MainView: View {
    @FetchRequest(sortDescriptors: [SortDescriptor(\.id)]) var suras: FetchedResults<Sura>
    @FetchRequest(sortDescriptors: [SortDescriptor(\.id)]) var ayas: FetchedResults<Sura>
    @FetchRequest(sortDescriptors: [SortDescriptor(\.id)]) var sofhas: FetchedResults<Sofha>

    @EnvironmentObject var model: Model
    @EnvironmentObject var quranVM: QuranViewModel
    @EnvironmentObject var suraVM: SuraViewModel
    @EnvironmentObject var searchVM: SearchModel
    @EnvironmentObject var ayaVM: AyaViewModel
    @State var searchText = ""
    @State var isHideCloseButton = false
    
    var body: some View {
        Container(
            selectedDetent: $quranVM.selectedDetent,
            isCover: $quranVM.isShow,
            isHideCloseButton: $isHideCloseButton,
            content: {
            NavigationStack{
                HomeView(text: $searchText)
                .scrollContentBackground(.hidden)
                .background(Color("bg"))
                .toolbar{
                    ToolbarItem(placement: .navigationBarLeading){
                        NavigationLink("Settings"){
                            SettingsView()
                                .navigationTitle("Settings")
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
                sofhas: sofhas.map{$0}
            )
                .preferredColorScheme(model.preferredColorScheme)
                .environmentObject(quranVM)
                .environmentObject(suraVM)
        }, overlay: {
            QuranView(isHideCloseButton: $isHideCloseButton)
        })
        
    }
}


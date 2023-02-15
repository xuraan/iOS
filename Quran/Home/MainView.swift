//
//  MainView.swift
//  Quran
//
//  Created by Samba Diawara on 2023-01-29.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var model: Model
    @EnvironmentObject var searchVM: SearchModel
    @EnvironmentObject var quranVM: QuranViewModel
    @State var searchText = ""
    @State var isHideCloseButton = false
    @FetchRequest(sortDescriptors: [SortDescriptor(\.id)]) var suras: FetchedResults<Sura>
    @FetchRequest(sortDescriptors: [SortDescriptor(\.id)]) var sofhas: FetchedResults<Sofha>
    var body: some View {
        MainContainer{
            content
        } cover: {
            QuranView(isHideCloseButton: $isHideCloseButton)
        }
    }
}

//MARK: - MainContent
extension MainView {
    @ViewBuilder
    var content: some View {
        NavigationStack{
            HomeView(text: $searchText)
                .toolbar{
                    toolbarContent()
                }
                .searchable(text: $searchText, tokens: $searchVM.tokens, token: { token in
                    Text(LocalizedStringKey(token.rawValue))
                })
        }
    }
}

//MARK: - Toolbar
extension MainView {
    @ToolbarContentBuilder
    func toolbarContent() -> some ToolbarContent {
        ToolbarItem(placement: .navigationBarLeading) {
            CustomSheet("Settings") {
                SettingsView()
                .presentationDetents(.init([.height(650)]))
            }
        }
        ToolbarItemGroup(placement: .navigationBarTrailing){
            NavigationSheet {
                FavoriteView()
            } label: {
                Label("Favorite", systemImage: "star")
            }
            NavigationSheet(closeButtonSystemName: "xmark", presentationDetents: .init([.height(600)])) {
                AddKollectionView()
            } label: {
                Label("New collection", systemImage: "plus.rectangle.on.rectangle")
            }
        }
    }
}

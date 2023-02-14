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
    @State var stack: NavigationPath = .init()
    @FetchRequest(sortDescriptors: [SortDescriptor(\.id)]) var suras: FetchedResults<Sura>
    @FetchRequest(sortDescriptors: [SortDescriptor(\.id)]) var sofhas: FetchedResults<Sofha>
    var body: some View {
        MainContainer{
            NavigationStack{
                HomeView(text: $searchText)
                    .toolbar{
                        ToolbarItem(placement: .navigationBarLeading) {
                            CustomSheet("Settings") {
                                NavigationStack(path: $stack){
                                    SettingsView(stack: $stack)
                                        .toolbar(content: {
                                            CloseButton()
                                        })
                                        .navigationTitle("Settings")
                                        .navigationDestination(for: String.self){ value in
                                            if value == "ayaFontNames" {
                                                List{
                                                    Section{
                                                        ForEach(CustomFont.allCases){ font in
                                                            Button{
                                                                withAnimation{
                                                                    model.ayaArabicFont = font
                                                                }
                                                            } label: {
                                                                Label(title: {
                                                                    Text(font.rawValue).foregroundColor(.primary)
                                                                }, icon: {
                                                                    Image(systemName: "checkmark").opacity(model.ayaArabicFont == font ? 1 : 0)
                                                                })
                                                            }
                                                        }
                                                    }
                                                    
                                                    model.ayaArabicFont.text
                                                }
                                                .navigationTitle("Font")
                                            }
                                        }
                                        .navigationBarTitleDisplayMode(.inline)
                                        .scrollIndicators(.hidden)
                                }
                                .presentationDetents(.init([.height(650)]))
                            }
                        }
                        ToolbarItemGroup(placement: .navigationBarTrailing){
                            NavigationSheet {
                                FavoriteView()
                            } label: {
                                Label("Favorite", systemImage: "star")
                            }
                            NavigationSheet(closeButtonSystemName: "xmark", presentationDetents: .init([.height(500)])) {
                                AddKollectionView()
                            } label: {
                                Label("New collection", systemImage: "plus.rectangle.on.rectangle")
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
            }
        } cover: {
            QuranView(isHideCloseButton: $isHideCloseButton)
        }
    }
}


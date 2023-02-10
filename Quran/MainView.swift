//
//  MainView.swift
//  Quran
//
//  Created by Samba Diawara on 2023-01-29.
//

import SwiftUI

struct MainView: View {
    @Environment(\.favorite) var favorite
    @Environment(\.pinned) var pinned
    @Environment(\.colorScheme) var colorScheme

    @EnvironmentObject var model: Model
    @EnvironmentObject var quranVM: QuranViewModel
    @EnvironmentObject var suraVM: SuraViewModel
    @EnvironmentObject var searchVM: SearchModel
    @EnvironmentObject var ayaVM: AyaViewModel
    
    @State var searchText = ""
    @State var isHideCloseButton = false
    @State var showFavorites = false
    @State var showSettings = false
    @State var stack: NavigationPath = .init()
    @FetchRequest(sortDescriptors: [SortDescriptor(\.id)]) var suras: FetchedResults<Sura>
    @FetchRequest(sortDescriptors: [SortDescriptor(\.id)]) var sofhas: FetchedResults<Sofha>
    var body: some View {
        MainContainer{
            NavigationStack{
                HomeView(text: $searchText, pinned: pinned)
                    .toolbar{
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button("Settings"){
                                withAnimation{
                                    showSettings.toggle()
                                }
                            }
                        }
                        ToolbarItem(placement: .navigationBarLeading) {
                            Button{
                                withAnimation{
                                    showSettings.toggle()
                                }
                            }label: {
                                Image(systemName: "info.circle")
                            }
                        }
                        ToolbarItemGroup(placement: .bottomBar){
                            Button{
                                withAnimation{
                                    quranVM.isShowIndex = true
                                }
                            } label: {
                                Image(systemName: "list.dash.header.rectangle")
                            }
                            Button{
                                withAnimation{
                                    showFavorites.toggle()
                                }
                            } label: {
                                Image(systemName: "bolt.heart.fill")
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
            .customSheet(isPresented: $quranVM.isShowIndex){
                QuranIndexView()
                .preferredColorScheme(model.preferredColorScheme)
                .environmentObject(quranVM)
                .environmentObject(suraVM)
                .environmentObject(ayaVM)
            }
            .customDismissibleSheet(isPresented: $showFavorites){
                FavoriteView(favorite: favorite)
            }
            .customSheet(isPresented: $showSettings){
                NavigationStack(path: $stack){
                    SettingsView(stack: $stack)
                        .toolbar{
                            CloseButton()
                        }
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
                .presentationDetents([.height(625)])
            }
            .ignoresSafeArea(.keyboard)
        } cover: {
            QuranView(isHideCloseButton: $isHideCloseButton)
                .environment(\.favorite, favorite)
                .environment(\.pinned, pinned)
        } onHidden: {
            quranVM.setLastPage(suras: suras, sofhas: sofhas)
        }
    }
}


//
//  MainView.swift
//  Quran
//
//  Created by Samba Diawara on 2023-01-29.
//

import SwiftUI

struct MainView: View {
    @FetchRequest(
        sortDescriptors: [SortDescriptor(\.id)]
    ) var suras: FetchedResults<Sura>
    @FetchRequest(
        sortDescriptors: [SortDescriptor(\.id)]
    ) var ayas: FetchedResults<Sura>
    @FetchRequest(
        sortDescriptors: [SortDescriptor(\.id)]
    ) var sofhas: FetchedResults<Sofha>
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.safeArea) var safeArea

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
    @AppStorage("isBoraded") var isNotBoraded: Bool = !UserDefaults.standard.bool(forKey: "isBoraded")

    var body: some View {
        MainContainer{
            NavigationStack{
                HomeView(text: $searchText)
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
                FavoriteView()
                    .navigationTitle("Favorites")
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
            .customSheet(isPresented: $isNotBoraded){
                WelcomeScreen()
                    .presentationDetents([.height(150)])
                    .interactiveDismissDisabled()
            }
            .ignoresSafeArea(.keyboard)
        } cover: {
            QuranView(isHideCloseButton: $isHideCloseButton)
                .id(isNotBoraded)//to update quran view after boading
        }
    }
}


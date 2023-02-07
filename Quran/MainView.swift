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
    @State var stack: NavigationPath = .init()
    @AppStorage("isBoraded") var isNotBoraded: Bool = !UserDefaults.standard.bool(forKey: "isBoraded")

    var body: some View {
        ContainerBeta{
            NavigationStack(path: $stack){
                HomeView(text: $searchText)
                    .contentBG
                    .toolbar{
                        ToolbarItem(placement: .navigationBarLeading){
                            NavigationLink(value: "app_info", label: {
                                Label("About", systemImage: "info.circle")
                                    .labelStyle(.titleAndIcon)
                            })
                        }
                        ToolbarItemGroup(placement: .primaryAction){
                            Button{
                                withAnimation{
                                    quranVM.isShowIndex = true
                                }
                            } label: {
                                Image(systemName: "list.dash.header.rectangle")
                            }
                            NavigationLink(value: "settings"){
                                Label("settings", systemImage: "gear")
                            }
                            
                           
                        }
                    }
                    .navigationDestination(for: String.self){ value in
                    if value == "ayaFontNames" {
                        List{
                            Section{
                                ForEach(AyaViewModel.ayaFonts, id: \.self){ name in
                                    Button{
                                        withAnimation{
                                            ayaVM.ayaFontName = name
                                            stack.removeLast(1)
                                        }
                                    } label: {
                                        Label(title: {
                                            Text(name).foregroundColor(.primary)
                                        }, icon: {
                                            Image(systemName: "checkmark").opacity(ayaVM.ayaFontName == name ? 1 : 0)
                                        })
                                    }
                                }
                            } footer: {
                                if ayaVM.ayaFontName == "me_quran" {
                                    Text("Font detail me_quran")
                                } else {
                                    Text("Font detail amiri")
                                }
                            }
                        }
                        .navigationTitle("Font")
                    } else if value == "settings" {
                        SettingsView(stack: $stack)
                            .navigationTitle("Settings")
                            .contentBG

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
            .sheet(isPresented: $quranVM.isShowIndex){
                QuranIndexView()
                .preferredColorScheme(model.preferredColorScheme)
                .environmentObject(quranVM)
                .environmentObject(suraVM)
                .environmentObject(ayaVM)
            }
            .sheet(isPresented: $isNotBoraded){
                WelcomeScreen()
                    .presentationDetents([.medium])
                    .interactiveDismissDisabled()
            }
            .ignoresSafeArea(.keyboard)
        } slide: {
            QuranView(isHideCloseButton: $isHideCloseButton)
        }
    }
}


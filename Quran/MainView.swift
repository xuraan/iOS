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

    @EnvironmentObject var model: Model
    @EnvironmentObject var quranVM: QuranViewModel
    @EnvironmentObject var suraVM: SuraViewModel
    @EnvironmentObject var searchVM: SearchModel
    @EnvironmentObject var ayaVM: AyaViewModel
    
    @State var searchText = ""
    @State var isHideCloseButton = false
    @State var stack: NavigationPath = .init()

    var body: some View {
        Container(
            selectedDetent: $quranVM.selectedDetent,
            isCover: $quranVM.isShow,
            isHideCloseButton: $isHideCloseButton,
            content: {
                NavigationStack(path: $stack){
                HomeView(text: $searchText)
                .toolbar{
                    ToolbarItem(placement: .confirmationAction){
                        NavigationLink("Settings", value: "settings")
                    }
                    ToolbarItem(placement: .navigationBarLeading){
                        NavigationLink(value: "app_info", label: {
                            Label("About", systemImage: "info.circle")
                        })
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
                    } else if value == "settings" {
                        SettingsView(stack: $stack)
                            .navigationTitle("Settings")
                            .contentBG
                    }
                }
                .contentBG
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


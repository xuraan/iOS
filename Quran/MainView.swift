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

    var body: some View {
        NavigationStack(path: $stack){
            HomeView(text: $searchText)
                .contentBG
                .overlay(alignment: .bottomTrailing){
                    Button(action: quranVM.show){
                        Image(systemName: "book.fill")
                            .padding(15)
                            .font(.title3)
                            .foregroundColor(colorScheme != .dark ? .white : .black)
                            .background{
                                Circle()
                                    .fill(colorScheme == .dark ? .white : .black)
                            }
                    }
                    .offset(y: safeArea.bottom/2)
                    .offset(x: -safeArea.bottom/3)
                }
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
        .scaleEffect(quranVM.isShow ? 2 : 1)
        .blur(radius: quranVM.isShow ? 30 : 0)
        .overlay{
            QuranView(isHideCloseButton: $isHideCloseButton)
                .overlay(alignment: .topTrailing, content: {
                    CloseButton(action: quranVM.hide)
                    .padding(.horizontal, 7)
                    .opacity(isHideCloseButton ? 0 : 1)
                })
                .opacity(quranVM.isShow ? 1 : 0)
                .animation(.easeInOut.delay(quranVM.isShow ? 0.2 : -1), value: quranVM.isShow)
        }
        .sheet(isPresented: $quranVM.isShowIndex){
            QuranIndexView()
            .preferredColorScheme(model.preferredColorScheme)
            .environmentObject(quranVM)
            .environmentObject(suraVM)
            .environmentObject(ayaVM)
        }
        .ignoresSafeArea(.keyboard)
    }
}


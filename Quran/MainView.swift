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
    @State var showSettings = false
    @State var stack: NavigationPath = .init()
    @AppStorage("isBoraded") var isNotBoraded: Bool = !UserDefaults.standard.bool(forKey: "isBoraded")

    var body: some View {
        MainContainer{
            NavigationStack{
                HomeView(text: $searchText)
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
                            Button{
                                withAnimation{
                                    showSettings.toggle()
                                }
                            } label: {
                                Image(systemName: "gear")
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
            .sheet(isPresented: $quranVM.isShowIndex){
                QuranIndexView()
                .preferredColorScheme(model.preferredColorScheme)
                .environmentObject(quranVM)
                .environmentObject(suraVM)
                .environmentObject(ayaVM)
                .onAppear{
                    guard let windows = UIApplication.shared.connectedScenes.first as? UIWindowScene else{
                        return
                    }

                    if let controller =  windows.windows.first?.rootViewController?
                        .presentedViewController, let sheet = controller.presentationController as? UISheetPresentationController{
                    // MARK: As Usual Set Properties What Ever Your Wish Here With Sheet
                    
                        controller.presentingViewController?.view.tintAdjustmentMode = .normal
                        sheet.largestUndimmedDetentIdentifier = .large
                        sheet.preferredCornerRadius = 30
                    }else{
                    print ("NO CONTROLLER FOUND" )
                    }
                }
            }
            .sheet(isPresented: $showSettings){
                NavigationStack(path: $stack){
                    SettingsView(stack: $stack)
                        .toolbar{
                            CloseButton()
                        }
                        .navigationTitle("Settings")
//                        .contentBG
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
                .onAppear{
                    guard let windows = UIApplication.shared.connectedScenes.first as? UIWindowScene else{
                        return
                    }

                    if let controller =  windows.windows.first?.rootViewController?
                        .presentedViewController, let sheet = controller.presentationController as? UISheetPresentationController{
                    // MARK: As Usual Set Properties What Ever Your Wish Here With Sheet
                    
                        controller.presentingViewController?.view.tintAdjustmentMode = .normal
                        sheet.largestUndimmedDetentIdentifier = .large
                        sheet.preferredCornerRadius = 30
                    }else{
                    print ("NO CONTROLLER FOUND" )
                    }
                }
            }
            .sheet(isPresented: $isNotBoraded){
                WelcomeScreen()
                    .presentationDetents([.medium])
                    .interactiveDismissDisabled()
            }
            .ignoresSafeArea(.keyboard)
        } cover: {
            QuranView(isHideCloseButton: $isHideCloseButton)
        }
    }
}


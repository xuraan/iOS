//
//  HomeView.swift
//  Quran
//
//  Created by Samba Diawara on 2023-02-21.
//

import SwiftUI

struct HomeView: View {
    @Environment(\.pin) var pin
    @Environment(\.showCoverView) var showCoverView
    @Environment(\.isSearching) var isSearching
    var body: some View {
        List{
            if isSearching {
                SearchView()
            } else {
                if let item = pin.wrappedValue {
                    QuranItemRow(for: item)
                    .environment(\.isDestructivePinButton, true)
                }
                KollectionSection(kollections: KollectionProvider.immutables)
                KollectionSection()
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                SheetButton("Settings") {
                    SettingsView()
                    .presentationDetents(.init([.height(650)]))
                }
            }
            ToolbarItemGroup(placement: .primaryAction) {
                SheetButton {
                    NavigationStack{
                        KollectionEditor()
                    }
                    .presentationDetents([.height(470)])
                } label: {
                    Image(systemName: "plus")
                }
                
                NavigationButtomSheet {
                    QuranIndeView()
                } label: {
                    Image(systemName: "list.bullet.rectangle.portrait")
                }

            }
        }
        .overlay(alignment: .bottomLeading) {
            NavigationButtomSheet {
                FavoriteView()
            } label: {
                Image(systemName: "star.fill")
                    .glassBackground(font: .title3, color: .yellow)
            }
            .padding(.leading)
            .opacity(isSearching ? 0 : 1)
        }
    }
}

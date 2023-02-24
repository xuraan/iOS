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
                    .presentationDetents(.init([.height(550)]))
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
                    .font(.title)
                    .foregroundColor(.accentColor)
                    .padding(12)
                    .background {
                        Circle()
                            .fill(.ultraThinMaterial.shadow(.inner(color: .accentColor.opacity(0.1), radius: 5)))
                    }
                    .padding(-1)
                    .clipShape(Circle())
                    
            }
            .padding(.leading)
            .opacity(isSearching ? 0 : 1)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            HomeView()
                .environmentObject(KollectionProvider())
        }
    }
}

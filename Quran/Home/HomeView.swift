//
//  HomeView.swift
//  Quran
//
//  Created by Samba Diawara on 2023-01-26.
//

import SwiftUI
import CoreData

struct HomeView: View {
    @EnvironmentObject var quranVM: QuranViewModel
    @Environment(\.showCoverView) var showSlideView
    @Environment(\.isSearching) var isSearching
    @ObservedObject var pinned: Kollection
    @Binding var text: String
    
    init(text: Binding<String> = .constant(""), pinned: Kollection) {
        self._text = text
        self.pinned = pinned
    }
    
    var body: some View {
        List{
            if isSearching {
                SearchView(text: $text)
                    .environment(\.isDestructive, false)
            } else {
                HStack{
                    Spacer()
                    Button(action: showSlideView, label: {
                        Text("Open quran").font(.headline)
                    })
                    .buttonStyle(.borderless)
                }
                .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                .listRowBackground(Color.clear)
                KollectionItemsSection(
                    for: pinned,
                    suraSectionTitle: "pinned suras",
                    ayaSectionTitle: "pinned ayas",
                    sofhaSectionTitle: "pinned sofhas")
                .environment(\.pinned, pinned)
                .environment(\.isPennedDestructive, true)
            }
        }
        .environment(\.isDestructive, false)

        .animation(.easeInOut, value: pinned.ayas.count)
        .listStyle(.insetGrouped)
        .navigationTitle(isSearching ? "Search" : "The noble quran")
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}

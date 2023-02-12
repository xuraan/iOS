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
    @Environment(\.pinned) var pinned
    @Binding var text: String
    
    init(text: Binding<String> = .constant("")) {
        self._text = text
    }
    
    var body: some View {
        List{
            if isSearching {
                SearchView(text: $text)
                    .environment(\.isDestructive, false)
            } else {
                if let page = quranVM.lastPage {
                    lastPage(page: page)
                        .onTapGesture(perform:  showSlideView)
                }
                KollectionItemsSection(
                    for: pinned,
                    suraSectionTitle: "pinned suras",
                    ayaSectionTitle: "pinned ayas",
                    sofhaSectionTitle: "pinned sofhas")
                .environment(\.isPennedDestructive, true)
                .environment(\.isDestructive, false)
                KollectionsSection()
            }
        }
        .environment(\.pinned, pinned)
        .navigationTitle(isSearching ? "Search" : "The noble quran")
    }
    
    @ViewBuilder
    func lastPage(page: Any) -> some View {
        Group{
            if let sura = page as? Sura {
                SuraRow(for: sura, action: { quranVM.suraOpenAction(sura) })
            } else if let sofha = page as? Sofha {
                SofhaRow(for: sofha, action: { quranVM.sofhaOpenAction(sofha) })
            }
        }
        .padding(.vertical, -7)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}

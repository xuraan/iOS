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
                pinnedView()
                    .environment(\.isPennedDestructive, true)
                KollectionsSection()
            }
        }
        .navigationTitle(isSearching ? "Search" : "The noble quran")
    }
    
    @ViewBuilder
    func pinnedView() -> some View {
        Group{
            if let sura = pinned.wrappedValue as? Sura {
                SuraRow(for: sura, action: { quranVM.suraOpenAction(sura) })
            } else if let sofha = pinned.wrappedValue as? Sofha {
                SofhaRow(for: sofha)
            } else if let aya = pinned.wrappedValue as? Aya {
                AyaRow(for: aya)
            }
        }
        .padding(.vertical, -6)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}

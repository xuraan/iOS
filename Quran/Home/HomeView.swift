//
//  HomeView.swift
//  Quran
//
//  Created by Samba Diawara on 2023-01-26.
//

import SwiftUI
import CoreData

struct HomeView: View {
    @Environment(\.pinned) var pinned
    @Environment(\.isSearching) var isSearching
    @Environment(\.showCoverView) var showCoverView
    @EnvironmentObject var model: Model
    @EnvironmentObject var quranVM: QuranViewModel
    @EnvironmentObject var suraVM: SuraViewModel
    @EnvironmentObject var ayaVM: AyaViewModel
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
               content
            }
        }
        .navigationTitle(title)
    }
    var title: String { isSearching ? "Search" : "The noble quran" }
}

//MARK: - content
extension HomeView {
    @ViewBuilder
    var content: some View {
        Section{
            HStack{
                CustomSheet("Quran index") {
                    QuranIndexView()
                    .preferredColorScheme(model.preferredColorScheme)
                    .environmentObject(quranVM)
                    .environmentObject(suraVM)
                    .environmentObject(ayaVM)
                }
                Spacer()
                Button("Open quran", action: showCoverView)
            }
            .buttonStyle(.borderless)
            .listRowBackground(Color.clear)
            .listRowInsets(EdgeInsets())
        }
        pinnedView()
            .environment(\.isPennedDestructive, true)
        KollectionsSection()
    }
}

//MARK: - PinnedView
extension HomeView {
    @ViewBuilder
    func pinnedView() -> some View {
        if pinned.wrappedValue.isNotNil {
            Section{
                if let sura = pinned.wrappedValue as? Sura {
                    SuraRow(for: sura)
                } else if let sofha = pinned.wrappedValue as? Sofha {
                    SofhaRow(for: sofha)
                } else if let aya = pinned.wrappedValue as? Aya {
                    AyaRow(for: aya)
                }
            }
            .padding(.vertical, -7)
        }
    }
}

//
//  AyaList.swift
//  Quran
//
//  Created by Samba Diawara on 2023-01-27.
//

import SwiftUI

struct AyaList: View {
    var ayas: [Aya]
    @State var searchResult: [Aya]
    @Binding var selection: Set<Aya.ID>
    @State var text: String = ""
    @EnvironmentObject var searchVM: SearchModel
    @EnvironmentObject var quran: QuranViewModel
    @Environment(\.dismiss) var dismiss
    @Environment(\.editMode) var editMode

    init(ayas: [Aya]) {
        self.ayas = ayas
        self._searchResult = State(initialValue: ayas)
        _selection = .constant(.init())
    }
    init(ayas: [Aya], selection: Binding<Set<Aya.ID>>) {
        self.ayas = ayas
        self._searchResult = State(initialValue: ayas)
        self._selection = selection
    }
    var body: some View {
        Group{
            if editMode?.wrappedValue == .active {
                List(searchResult, selection: $selection){ aya in
                    AyaRow(for: aya, action: { selection.toggle(aya.id) })
                        .fullSeparatore
                        .tag(aya.id)
                }
            } else {
                List(searchResult){ aya in
                    AyaRow(for: aya)
                        .fullSeparatore
                }
            }
        }
        .listStyle(.grouped)
        .padding(.top, -10)
        .toolbarBackground(.hidden, for: .navigationBar)
        .navigationBarTitleDisplayMode(.inline)
        .searchable(text: $text, prompt: "Search a sura in this list" )
        .onChange(of: text){ value in
            if value.isEmpty {
                searchResult = ayas
            } else {
                Task{
                    searchResult = await searchVM.search(text: text.lowercased(), in: ayas)
                }
            }
        }
        .safeAreaInset(edge: .top){ AyaListHeader() }
    }
    
}

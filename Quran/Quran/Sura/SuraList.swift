//
//  SuraList.swift
//  Quran
//
//  Created by Samba Diawara on 2023-01-26.
//

import SwiftUI

struct SuraList: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.editMode) var editMode
    var suras: [Sura]
    @State var searchResult: [Sura]
    @Binding var selection: Set<Sura.ID>
    @State var text: String = ""

    @EnvironmentObject var searchVM: SearchModel
    @EnvironmentObject var quran: QuranViewModel
    
    init(suras: [Sura]) {
        self.suras = suras
        self._searchResult = State(initialValue: suras)
        self._selection = .constant(.init())
    }
        
    init(suras: [Sura], selection: Binding<Set<Sura.ID>>) {
        self.suras = suras
        self._searchResult = State(initialValue: suras)
        self._selection = selection
    }
    
    var body: some View {
        Group{
            if editMode?.wrappedValue == .active {
                List(searchResult, selection: $selection){ sura in
                    SuraRow(for: sura, action: {selection.toggle(sura.id)})
                        .fullSeparatore
                        .tag(sura.id)
                }
            } else {
                List(searchResult){ sura in
                    SuraRow(for: sura)
                        .fullSeparatore
                }
            }
        }
        .listStyle(.plain)
        .padding(.top, -10)
        .toolbarBackground(.hidden, for: .navigationBar)
        .navigationBarTitleDisplayMode(.inline)
        .searchable(text: $text, prompt: "Search a sura in this list")
        .onChange(of: text){ value in
            if value.isEmpty {
                searchResult = suras
            } else {
                Task{
                    searchResult = await searchVM.search(text: text.lowercased(), in: suras)
                }
            }
        }
        .safeAreaInset(edge: .top){
            SuraListHeader()
        }
    }
}



extension Set {
    mutating func toggle(_ element: Element) {
        if contains(element) {
            remove(element)
        } else {
            insert(element)
        }
    }
}

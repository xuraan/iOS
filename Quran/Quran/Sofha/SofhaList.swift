//
//  SofhaList.swift
//  Quran
//
//  Created by Samba Diawara on 2023-01-26.
//

import SwiftUI

struct SofhaList: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.editMode) var editMode

    var sofhas: [Sofha]
    @State var searchResult: [Sofha]
    @Binding var selection: Set<Sofha.ID>
    @State var text: String = ""
    @EnvironmentObject var searchVM: SearchModel
    @EnvironmentObject var quran: QuranViewModel
    init(sofhas: [Sofha]) {
        self.sofhas = sofhas
        self._searchResult = State(initialValue: sofhas)
        _selection = .constant(.init())
    }
    init(sofhas: [Sofha], selection: Binding<Set<Sofha.ID>>) {
        self.sofhas = sofhas
        self._searchResult = State(initialValue: sofhas)
        self._selection = selection
    }

    var body: some View {
        Group{
            if editMode?.wrappedValue == .active {
                List(searchResult, selection: $selection){ sofha in
                    SofhaRow(for: sofha, action: { selection.toggle(sofha.id) })
                        .fullSeparatore
                        .tag(sofha.id)
                }
            } else {
                List(searchResult){ sofha in
                    SofhaRow(for: sofha)
                        .fullSeparatore
                }
            }
        }
        
        .listStyle(.plain)
        .padding(.top, -10)
        .background(Color("bg"))
        .toolbarBackground(.hidden, for: .navigationBar)
        .navigationBarTitleDisplayMode(.inline)
        .searchable(text: $text, prompt: "Search a sura in this list" )
        .onChange(of: text){ value in
            if value.isEmpty {
                searchResult = sofhas
            } else {
                Task{
                    searchResult = await searchVM.search(text: text.lowercased(), in: sofhas)
                }
            }
        }
        .safeAreaInset(edge: .top){
            SofhaListHeader()
        }
    }
}

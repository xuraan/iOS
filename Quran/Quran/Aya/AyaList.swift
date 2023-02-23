//
//  AyaList.swift
//  Quran
//
//  Created by Samba Diawara on 2023-02-21.
//

import SwiftUI

struct AyaList: View {
    let ayas: [Aya]
    var selection: Binding<Set<Aya>>?
    @State var text: String = ""
    @State var searchResult: Array<Aya> = .init()

    init(ayas: [Aya] = Aya.all) {
        self.ayas = ayas
        self._searchResult = State(initialValue: ayas)
    }
    
    init(ayas: [Aya] = Aya.all, selection: Binding<Set<Aya>>) {
        self.ayas = ayas
        self._searchResult = State(initialValue: ayas)
        self.selection = selection
    }
    
    var body: some View {
        Group{
            if let selection = selection {
                List(searchResult, selection: selection){ aya in
                    AyaRow(for: aya){
                        selection.wrappedValue.toggle(aya)
                    }
                    .tag(aya)
                }
                .environment(\.editMode, .constant(.active))
            } else {
                List(searchResult){ aya in
                    AyaRow(for: aya)
                        .fullSeparatoreListPlain
                }
            }
        }
        
        .listStyle(.plain)
        .navigationBarTitleDisplayMode(.inline)
        .searchable(text: $text, prompt: "Search a sura in this list" )
        .onChange(of: text){ value in
            if value.isEmpty {
                searchResult = ayas
            } else {
                Task{
                    searchResult = await QuranProvider.shared.searchAyas(text: text)
                }
            }
        }
    }
}

struct AyaList_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            AyaList()
        }
        
        AyaList()
            .environment(\.editMode, .constant(.active))
        
    }
}




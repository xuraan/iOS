//
//  SuraList.swift
//  Quran
//
//  Created by Samba Diawara on 2023-02-21.
//

import SwiftUI

struct SuraList: View {
    let suras: [Sura]
    @State var searchResult: [Sura]
    @State var text: String = ""
    var selection: Binding<Set<Sura>>?
    init(suras: [Sura] = Sura.all) {
        self.suras = suras
        self._searchResult = State(initialValue: suras)
    }
    
    init(suras: [Sura] = Sura.all, selection: Binding<Set<Sura>>) {
        self.suras = suras
        self._searchResult = State(initialValue: suras)
        self.selection = selection
    }
    
    var body: some View {
        Group{
            if let selection = selection {
                List(searchResult, selection: selection){ sura in
                    SuraRow(for: sura) {
                        selection.wrappedValue.toggle(sura)
                    }
                    .tag(sura)
                }
                .environment(\.editMode, .constant(.active))
            } else {
                List {
                    Section{
                        ForEach(searchResult){ sura in
                            SuraRow(for: sura)
                        }
                        .fullSeparatoreListPlain
                    }
                    .listSectionSeparator(.hidden)
                }
            }
        }
        
        .listStyle(.plain)
        .toolbarBackground(.hidden, for: .navigationBar)
        .padding(.top, -10)
        .navigationBarTitleDisplayMode(.inline)
        .searchable(text: $text, prompt: "Search a sura in this list" )
        .onChange(of: text){ value in
            if value.isEmpty {
                searchResult = suras
            } else {
                Task{
                    searchResult = await QuranProvider.shared.searchSuras(text: text)
                }
            }
        }
        .safeAreaInset(edge: .top){
            HStack{
                if selection != nil {
                    HStack{}.frame(width: 35, alignment: .leading)
                }
                Text("Rank")
                    .frame(width: 35, alignment: .leading)
                
                HStack{
                    Text("Phonetic")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Text("Translation")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Text("sura")
                        .frame(maxWidth: .infinity, alignment: .trailing)
                    
                }
                .environment(\.layoutDirection, .leftToRight)
                
                .frame(maxWidth: .infinity, alignment: .center)
            }
            .padding( .bottom, 5)
            .frame(height: 20)
            .font(.footnote)
            .foregroundColor(.secondary)
            .padding(.horizontal)
            .background(.bar)
            .overlay(alignment: .bottom){
                Divider()
            }
            .environment(\.layoutDirection, .leftToRight)
            
        }
    }
}

struct SuraList_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            SuraList()
        }
        
        SuraList()
            .environment(\.editMode, .constant(.active))
    }
}

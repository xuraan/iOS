//
//  HizbList.swift
//  Quran
//
//  Created by Samba Diawara on 2023-02-21.
//

import SwiftUI

struct HizbList: View {
    let hizbs: [Hizb]
    @State var searchResult: [Hizb]
    @State var text: String = ""
    var selection: Binding<Set<Hizb>>?

    init(hizbs: [Hizb] = Hizb.all) {
        self.hizbs = hizbs
        self._searchResult = State(initialValue: hizbs)
    }
    
    init(hizbs: [Hizb] = Hizb.all, selection: Binding<Set<Hizb>>) {
        self.hizbs = hizbs
        self._searchResult = State(initialValue: hizbs)
        self.selection = selection
    }
    
    var body: some View {
        Group{
            if let selection = selection {
                List(searchResult, selection: selection){ hizb in
                    HizbRow(for: hizb)
                        .disabled(true)
                        .tag(hizb)
                }
                .environment(\.editMode, .constant(.active))
            } else {
                List {
                    Section{
                        ForEach(searchResult){ hizb in
                            HizbRow(for: hizb)
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
        .searchable(text: $text, prompt: "Search an hizb in this list" )
        .onChange(of: text){ value in
            if value.isEmpty {
                searchResult = hizbs
            } else {
                Task{
                    searchResult = await QuranProvider.shared.searchHizb(text: text)
                }
            }
        }
        .safeAreaInset(edge: .top){
            HStack{
                if selection != nil {
                    HStack{
                        
                    }
                    .frame(width: 35, alignment: .leading)
                }
                Text("NO")
                    .frame(width: 35, alignment: .leading)
                Text("Firt aya")
                    .frame(maxWidth: .infinity, alignment: .center)
                    .offset(x: -25)
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

struct HizbList_Previews: PreviewProvider {
    static var previews: some View {
        HizbList()
    }
}

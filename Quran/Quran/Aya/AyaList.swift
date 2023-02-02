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
    @State var selection: Aya?
    @State var text: String = ""
    @EnvironmentObject var searchVM: SearchModel
    @EnvironmentObject var quran: QuranViewModel
    init(ayas: [Aya]) {
        self.ayas = ayas
        self.searchResult = ayas
    }
    var body: some View {
        List(searchResult, id: \.self, selection: $selection){ aya in
            AyaRow(for: aya)
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
        .safeAreaInset(edge: .top){
            HStack{
                Text("ID")
                    .frame(width: 35, alignment: .leading)

                HStack{
                    
                    Text("Phonetic")
                        .frame(maxWidth: .infinity, alignment: .trailing)
                    Text("Translation")
                        .frame(maxWidth: .infinity, alignment: .trailing)
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
        .onChange(of: selection){ value in
            if let value = value {
                quran.ayaOpenAction(value)
            }
        }
    }
}

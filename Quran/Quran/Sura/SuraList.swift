//
//  SuraList.swift
//  Quran
//
//  Created by Samba Diawara on 2023-01-26.
//

import SwiftUI

struct SuraList: View {
    var suras: [Sura]
    @State var searchResult: [Sura]
    @State var selection: Sura?
    @State var text: String = ""
    @EnvironmentObject var searchVM: SearchModel
    @EnvironmentObject var quran: QuranViewModel
    init(suras: [Sura]) {
        self.suras = suras
        self.searchResult = suras
    }
    
    var body: some View {
        
        List(searchResult, id: \.self, selection: $selection){ sura in
            SuraRow(for: sura)
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
            HStack{
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
        .onChange(of: selection){ value in
            if let value = value {
                quran.suraOpenAction(value)
                selection = nil
            }
        }
    }
}


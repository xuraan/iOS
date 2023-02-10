//
//  SofhaList.swift
//  Quran
//
//  Created by Samba Diawara on 2023-01-26.
//

import SwiftUI

struct SofhaList: View {
    @Environment(\.dismiss) var dismiss
    var sofhas: [Sofha]
    @State var searchResult: [Sofha]
    @State var selection: Sofha?
    @State var text: String = ""
    @EnvironmentObject var searchVM: SearchModel
    @EnvironmentObject var quran: QuranViewModel
    init(sofhas: [Sofha]) {
        self.sofhas = sofhas
        self._searchResult = State(initialValue: sofhas)
    }
    var body: some View {
        List(searchResult, id: \.self, selection: $selection){ sofha in
            SofhaRow(for: sofha).fullSeparatore
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
            HStack{
                
                Text("Page")
                    .frame(width: 35, alignment: .leading)

                HStack{
                    
                    Text("Last aya")
                        .frame(maxWidth: .infinity, alignment: .trailing)
                    Text("First aya")
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
                dismiss()
                DispatchQueue.main.asyncAfter(deadline: .now()+0.3){
                    quran.sofhaOpenAction(value)
                }
            }
        }
    }
}

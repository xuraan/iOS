//
//  SofhaList.swift
//  Quran
//
//  Created by Samba Diawara on 2023-02-21.
//

import SwiftUI

struct SofhaList: View {
    let sofhas: [Sofha]
    @State var searchResult: [Sofha]
    @State var text: String = ""
    var selection: Binding<Set<Sofha>>?
    init(sofhas: [Sofha] = Sofha.all) {
        self.sofhas = sofhas
        self.searchResult = sofhas
    }
    
    init(sofhas: [Sofha] = Sofha.all, selection: Binding<Set<Sofha>>) {
        self.sofhas = sofhas
        self.searchResult = sofhas
        self.selection = selection
    }
    var body: some View {
        Group{
            if let selection = selection {
                List(searchResult, selection: selection) { sofha in
                    SofhaRow(for: sofha)
                        .disabled(true)
                        .tag(sofha)
                }
                .environment(\.editMode, .constant(.active))
            } else {
                List{
                    Section{
                        ForEach(searchResult){ sofha in
                            SofhaRow(for: sofha)
                        }
                        .fullSeparatoreListPlain
                    }
                    .listSectionSeparator(.hidden)
                }
            }
        }
        
        .toolbarBackground(.hidden, for: .navigationBar)
        .padding(.top, -10)
        .safeAreaInset(edge: .top){
            HStack{
                if selection != nil {
                    HStack{}.frame(width: 35, alignment: .leading)
                }
            
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
        .listStyle(.plain)
        .animation(.easeInOut, value: sofhas)
        .navigationBarTitleDisplayMode(.inline)
        .searchable(text: $text, prompt: "Search a sofha in this list" )
        .onChange(of: text){ value in
            if value.isEmpty {
                searchResult = sofhas
            } else {
                Task{
                    searchResult = await QuranProvider.shared.searchSofhas(text:text)
                }
            }
        }
    }
}

//
//  SearchView.swift
//  Quran
//
//  Created by Samba Diawara on 2023-01-26.
//

import SwiftUI

struct SearchView: View {
    @EnvironmentObject var searchVM: SearchModel
    @Binding var text: String
    @State var surasResult: [Sura] = []
    @State var ayasResult: [Aya] = []
    @State var sofhasResult: [Sofha] = []
    @FetchRequest(sortDescriptors: [SortDescriptor(\.id)]) var suras: FetchedResults<Sura>
    @FetchRequest(sortDescriptors: [SortDescriptor(\.id)]) var ayas: FetchedResults<Aya>
    @FetchRequest(sortDescriptors: [SortDescriptor(\.id)]) var sofhas: FetchedResults<Sofha>
    init(text: Binding<String>){
        self._text = text
    }
    var body: some View {
            Section{
                if text.isEmpty && searchVM.tokens.isEmpty {
                    Label("sura", systemImage: "link").searchCompletion(SearchModel.Token.sura)
                    Label("sofha", systemImage: "link").searchCompletion(SearchModel.Token.sofha)
                    Label("aya", systemImage: "link").searchCompletion(SearchModel.Token.aya)
                }
            } header: {
                if text.isEmpty && searchVM.tokens.isEmpty {
                    Text("Search in")
                }
            }
            .onChange(of: text){ value in
                search()
            }
            suraSection()
            ayaSection()
            sofhaSection()
        
    }
}

//MARK: - Search logic
extension SearchView {
    func search(){
        Task{
            if let token = searchVM.tokens.first {
                switch token {
                    
                case .sura: surasResult = await searchVM.search(text: text.lowercased(), in: suras)
                case .aya:  ayasResult = await searchVM.search(text: text.lowercased(), in: ayas)
                case .sofha: sofhasResult = await searchVM.search(text: text, in: sofhas)

                }
            } else {
                surasResult = await searchVM.search(text: text.lowercased(), in: suras)
                ayasResult = await searchVM.search(text: text.lowercased(), in: ayas)
                sofhasResult = await searchVM.search(text: text.lowercased(), in: sofhas)
            }
        }
    }
}


//MARK: - SwiftUI
extension SearchView {
    @ViewBuilder
    func suraSection() -> some View {
        if !surasResult.isEmpty {
            Section{
                ForEach(surasResult.shuffled().prefix(3)){ sura in
                    SuraRow(for: sura)
                        .padding(.vertical, -5)
                }
            } header: {
                HStack{
                    Text("sura")
                    Spacer()
                    if surasResult.count > 3 {
                        MoreLink{
                            SuraList(suras: surasResult)
                            .navigationTitle("Sura result")
                            .toolbar{
                                ToolbarItem(placement: .status, content: {
                                    Text("\(surasResult.count) suras")
                                        .font(.footnote.bold())
                                        .foregroundColor(.secondary)
                                        .frame(height: 15)
                                })
                            }
                        }
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    func ayaSection() -> some View {
        if !ayasResult.isEmpty {
            Section{
                ForEach(ayasResult.shuffled().prefix(3)){ aya in
                    AyaRow(for: aya)
                        .padding(.vertical, -5)
                }
            } header: {
                HStack{
                    Text("aya")
                    Spacer()
                    if ayasResult.count > 3 {
                        MoreLink{
                            List(ayasResult){ aya in
                                AyaRow(for: aya)
                            }
                            .navigationTitle("Aya results")
                            .listStyle(.plain)
                            .toolbar{
                                ToolbarItem(placement: .status, content: {
                                    Text("\(ayasResult.count) aya")
                                        .font(.footnote.bold())
                                        .foregroundColor(.secondary)
                                        .frame(height: 15)
                                })
                            }

                        }
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    func sofhaSection() -> some View {
        if !sofhasResult.isEmpty {
            Section{
                ForEach(sofhasResult.shuffled().prefix(3)){ sofha in
                    SofhaRow(for: sofha)
                        .padding(.vertical, -5)
                }
            } header: {
                HStack{
                    Text("sofha")
                    Spacer()
                    if sofhasResult.count > 3 {
                        MoreLink{
                            SofhaList(sofhas: sofhasResult)
                            .toolbar{
                                ToolbarItem(placement: .status, content: {
                                    Text("\(sofhasResult.count) sura")
                                        .font(.footnote.bold())
                                        .foregroundColor(.secondary)
                                        .frame(height: 15)
                                })
                            }
                        }
                    }
                }
            }
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(text: .constant("text"))
            .environmentObject(SearchModel())
    }
}

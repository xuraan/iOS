//
//  SearchView.swift
//  Quran
//
//  Created by Samba Diawara on 2023-01-26.
//

import SwiftUI

struct SearchView: View {
    @EnvironmentObject var quranVM: QuranViewModel
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
        Section{}
            .opacity(0)
            .listRowBackground(Color.clear)
            .onChange(of: text){ value in
                search()
            }
        if text.isEmpty && searchVM.tokens.isEmpty {
            Section{
                    Button(action: {searchVM.tokens=[SearchModel.Token.sura]}){
                        Label("sura", systemImage: "link")
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }.fullSeparatore2
                    
                    Button(action: {searchVM.tokens = [SearchModel.Token.sofha]}){
                        Label("sofha", systemImage: "link")
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }.fullSeparatore2
                    
                    Button(action: {searchVM.tokens = [SearchModel.Token.aya]}){
                        Label("aya", systemImage: "link")
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }.fullSeparatore2
            } header: {
                if text.isEmpty && searchVM.tokens.isEmpty {
                    Text("Search in")
                }
            }
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
                surasResult = await searchVM.search(text: text.lowercased(), in: suras).shuffled()
                ayasResult = await searchVM.search(text: text.lowercased(), in: ayas).shuffled()
                sofhasResult = await searchVM.search(text: text.lowercased(), in: sofhas).shuffled()
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
                ForEach(surasResult.prefix(3)){ sura in
                    SuraRow(for: sura, action: {quranVM.suraOpenAction(sura)})
                }.fullSeparatore2
            } header: {
                HStack{
                    Text("sura")
                    Spacer()
                    if surasResult.count > 3 {
                        MoreLinkSheet(badge: surasResult.count){
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
                ForEach(ayasResult.prefix(3)){ aya in
                    AyaRow(for: aya, action: {quranVM.ayaOpenAction(aya)})
                }.fullSeparatore2
            } header: {
                HStack{
                    Text("aya")
                    Spacer()
                    if ayasResult.count > 3 {
                        MoreLinkSheet(badge: ayasResult.count){
                            AyaList(ayas: ayasResult)
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
                ForEach(sofhasResult.prefix(3)){ sofha in
                    SofhaRow(for: sofha, action: {quranVM.sofhaOpenAction(sofha)})
                }.fullSeparatore2
            } header: {
                HStack{
                    Text("sofha")
                    Spacer()
                    if sofhasResult.count > 3 {
                        MoreLinkSheet(badge: sofhasResult.count){
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

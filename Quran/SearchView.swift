//
//  SearchView.swift
//  Quran
//
//  Created by Samba Diawara on 2023-02-20.
//

import SwiftUI

struct SearchView: View {
    @EnvironmentObject var model: Model
    
    @State var ayas: [Aya] = []
    @State var suras: [Sura] = []
    @State var hizbs: [Hizb] = []
    @State var sofhas: [Sofha] = []
    
    var body: some View {
        ayaSection()
        hizbSection()
        sofhaSection()
        suraSection()
        
            .onReceive(model.$text){ text in
                search(text: text)
            }
    }
    
    @ViewBuilder
    func suraSection() -> some View {
        if let sura = suras.first {
            Section{
                SuraCard(for: sura)
            } header: {
                HStack{
                    Text("sura")
                    Spacer()
                    if suras.count > 2 {
                        NavigationButtomSheet {
                            SuraList(suras: suras)
                        } label: {
                            Label("More", systemImage: "link")
                                .font(.footnote)
                        }

                    }
                }
            }
        }
    }
    
    @ViewBuilder
    func ayaSection() -> some View {
        if let aya = ayas.first {
            Section{
                AyaCard(for: aya)
            } header: {
                HStack{
                    Text("aya")
                    Spacer()
                    if ayas.count > 2 {
                        NavigationButtomSheet {
                            AyaList(ayas: ayas)
                        } label: {
                            Label("More", systemImage: "link")
                                .font(.footnote)
                        }

                    }
                }
            }
        }
    }
    
    @ViewBuilder
    func sofhaSection() -> some View {
        if let sofha = sofhas.first {
            Section{
                SofhaCard(for: sofha)
            } header: {
                HStack{
                    Text("sofha")
                    Spacer()
                    if sofhas.count > 2 {
                        NavigationButtomSheet {
                            SofhaList(sofhas: sofhas)
                        } label: {
                            Label("More", systemImage: "link")
                                .font(.footnote)
                        }

                    }
                }
            }
        }
    }
    
    @ViewBuilder
    func hizbSection() -> some View {
        if let hizb = hizbs.first {
            Section{
                HizbCard(for: hizb)
            } header: {
                HStack{
                    Text("hizb")
                    Spacer()
                    if hizbs.count > 2 {
                        NavigationButtomSheet {
                            HizbList(hizbs: hizbs)
                        } label: {
                            Label("More", systemImage: "link")
                                .font(.footnote)
                        }

                    }
                }
            }
        }
    }

    func search(text: String){
        Task{
            suras = await QuranProvider.shared.searchSuras(text: text)
            sofhas = await QuranProvider.shared.searchSofhas(text: text)
            hizbs = await QuranProvider.shared.searchHizb(text: text)
            ayas = await QuranProvider.shared.searchAyas(text: text)
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
       SearchView()
    }
}

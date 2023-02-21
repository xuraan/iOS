//
//  SearchView.swift
//  Quran
//
//  Created by Samba Diawara on 2023-02-20.
//

import SwiftUI

struct SearchView: View {
    
    @Binding var ayas: [Aya]
    @Binding var suras: [Sura]
    @Binding var hizbs: [Hizb]
    @Binding var sofhas: [Sofha]
    
    init(
        ayas: Binding<[Aya]>,
        suras: Binding<[Sura]>,
        hizbs: Binding<[Hizb]>,
        sofhas: Binding<[Sofha]>
    ) {
        self._ayas = ayas
        self._suras = suras
        self._hizbs = hizbs
        self._sofhas = sofhas
    }
    
    var body: some View {
        List{
            ayaSection()
            hizbSection()
            sofhaSection()
            suraSection()
        }
        .scrollIndicators(.hidden)
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
                            List{}
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
                            List{}
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
                            List{}
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
                            List{}
                        } label: {
                            Label("More", systemImage: "link")
                                .font(.footnote)
                        }

                    }
                }
            }
        }
    }

}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
       SearchView(
        ayas: .constant(QuranProvider.shared.ayas(from: 3, to: 30)),
        suras: .constant(QuranProvider.shared.suras(from: 5, to: 80)),
        hizbs: .constant(QuranProvider.shared.hizbs(from: 2, to: 40)),
        sofhas: .constant(QuranProvider.shared.sofhas(from: 4, to: 50))
       )
    }
}

//
//  KollectionView.swift
//  Quran
//
//  Created by Samba Diawara on 2023-02-22.
//

import SwiftUI

struct KollectionView: View {
    @Environment(\.showCoverView) var showCoverView
    @EnvironmentObject var qModel: QuranViewModel
    @ObservedObject var kollection: Kollection
    init(for kollection: Kollection) {
        self.kollection = kollection
    }
    var body: some View {
        List{
            ayaSection()
            hizbSection()
            sofhaSection()
            suraSection()
        }
        .navigationTitle(kollection.name)
        .toolbar {
            SheetButton("Edit") {
                NavigationStack{
                    KollectionEditor(kollection: kollection)
                }
                .presentationDetents([.height(470)])
            }
        }
    }
    
    @ViewBuilder
    func suraSection() -> some View {
        if !kollection.suras.isEmpty {
            Section{
                ForEach(kollection.suras.prefix(3)) { sura in
                    SuraRow(for: sura){
                        if let aya = sura.ayas.first{
                            rowAction(aya: aya)
                        }
                    }
                }
            } header: {
                HStack{
                    Text("sura")
                    Spacer()
                    if kollection.suras.count > 3 {
                        NavigationButtomSheet {
                            SuraList(suras: kollection.suras)
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
        if !kollection.ayas.isEmpty {
            Section{
                ForEach(kollection.ayas.prefix(3)) { aya in
                    AyaRow(for: aya) {
                        rowAction(aya: aya)
                    }
                }
            } header: {
                HStack{
                    Text("aya")
                    Spacer()
                    if kollection.ayas.count > 3 {
                        NavigationButtomSheet {
                            AyaList(ayas: kollection.ayas)
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
        if !kollection.sofhas.isEmpty {
            Section{
                ForEach(kollection.sofhas.prefix(3)) { sofha in
                    SofhaRow(for: sofha){
                        if let aya = sofha.ayas.first{
                            rowAction(aya: aya)
                        }
                    }
                }
            } header: {
                HStack{
                    Text("sofha")
                    Spacer()
                    if kollection.sofhas.count > 3 {
                        NavigationButtomSheet {
                            SofhaList(sofhas: kollection.sofhas)
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
        if !kollection.hizbs.isEmpty {
            Section{
                ForEach(kollection.hizbs.prefix(3)) { hizb in
                    HizbRow(for: hizb){
                        if let aya = hizb.ayas.first{
                            rowAction(aya: aya)
                        }
                    }
                }
            } header: {
                HStack{
                    Text("hizb")
                    Spacer()
                    if kollection.hizbs.count > 3 {
                        NavigationButtomSheet {
                            HizbList(hizbs: kollection.hizbs)
                        } label: {
                            Label("More", systemImage: "link")
                                .font(.footnote)
                        }

                    }
                }
            }
        }
    }
    
    func rowAction(aya: Aya){
        showCoverView()
        qModel.openButtonAction(aya)
    }
}

struct KollectionView_Previews: PreviewProvider {
    static var previews: some View {
        KollectionView(for: KollectionProvider.favorite)
    }
}

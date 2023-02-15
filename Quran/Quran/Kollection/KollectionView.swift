//
//  KollectionView.swift
//  Quran
//
//  Created by Samba Diawara on 2023-02-09.
//

import SwiftUI

struct KollectionView: View {
    @EnvironmentObject var quranVM: QuranViewModel
    @EnvironmentObject var model: Model
    @ObservedObject var kollection: Kollection
    var suraSectionTitle: String
    var ayaSectionTitle: String
    var sofhaSectionTitle: String
    init(
        for kollection: Kollection,
        suraSectionTitle: String = "suras",
        ayaSectionTitle: String = "ayas",
        sofhaSectionTitle: String = "sofhas"
    ) {
        self.kollection = kollection
        self.suraSectionTitle = suraSectionTitle
        self.ayaSectionTitle = ayaSectionTitle
        self.sofhaSectionTitle = sofhaSectionTitle
    }
    var body: some View {
        List{
            if !kollection.descript.isEmpty {
                Section{
                    Group{
                        if Kollection.immutableIDs.contains(kollection.id){
                            Text(NSLocalizedString( "\(kollection.descript)", tableName: "quran+info", comment: "details"))
                        } else {
                            Text(kollection.descript)
                        }
                    }
                    .listRowInsets(EdgeInsets())
                    .listRowBackground(Color.clear)
                }
            }
            Section{
                ForEach(kollection.ayas.ayas.shuffled().prefix(10)){aya in
                    AyaRow(for: aya, action: {quranVM.ayaOpenAction(aya)})
                        .padding(.vertical, -5)
                        .fullSeparatore2
                }
            } header: {
                if !kollection.ayas.ayas.isEmpty {
                    HStack{
                        Text(ayaSectionTitle)
                        Spacer()
                        if kollection.ayas.count > 10 {
                            NavigationSheet {
                                AyaList(ayas: kollection.ayas.ayas)
                            } label: {
                                Label("aya \(kollection.ayas.count)", systemImage: "link")
                                    .font(.footnote)
                            }
                        }
                    }
                    
                }
            }
            Section{
                ForEach(kollection.sofhas.sofhas.shuffled().prefix(10)){sofha in
                    SofhaRow(for: sofha, action: {quranVM.sofhaOpenAction(sofha)})
                        .padding(.vertical, -5)
                        .fullSeparatore2
                }
            } header: {
                if !kollection.sofhas.sofhas.isEmpty {
                    HStack{
                        Text(sofhaSectionTitle)
                        Spacer()
                        if kollection.sofhas.count > 10 {
                            NavigationSheet {
                                SofhaList(sofhas: kollection.sofhas.sofhas)
                            } label: {
                                Label("sofhas \(kollection.sofhas.count)", systemImage: "link")
                                    .font(.footnote)
                            }
                        }
                    }
                }
            }
            Section{
                ForEach(kollection.suras.suras.shuffled().prefix(10)){sura in
                    SuraRow(for: sura, action: {quranVM.suraOpenAction(sura)})
                        .padding(.vertical, -5)
                        .fullSeparatore2
                }
            } header: {
                if !kollection.suras.suras.isEmpty {
                    HStack{
                        Text(suraSectionTitle)
                        Spacer()
                        if kollection.suras.count > 10 {
                            NavigationSheet {
                                SuraList(suras: kollection.suras.suras)
                            } label: {
                                Label("suras \(kollection.suras.count)", systemImage: "link")
                                    .font(.footnote)
                            }
                        }
                    }
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar{
            if !kollection.isImmutable {
                NavigationSheet(title: "Edit", presentationDetents: .init([.height(600)])) {
                    AddKollectionView(kollection: .constant(kollection))
                }
            }
        }
    }
}

struct KollectionItemsSection: View {
    @EnvironmentObject var quranVM: QuranViewModel
    @ObservedObject var kollection: Kollection
    var suraSectionTitle: String
    var ayaSectionTitle: String
    var sofhaSectionTitle: String
    init(
        for kollection: Kollection,
        suraSectionTitle: String = "suras",
        ayaSectionTitle: String = "ayas",
        sofhaSectionTitle: String = "sofhas"
    ) {
        self.kollection = kollection
        self.suraSectionTitle = suraSectionTitle
        self.ayaSectionTitle = ayaSectionTitle
        self.sofhaSectionTitle = sofhaSectionTitle
    }
    var body: some View {
        Section{
            ForEach(kollection.ayas.ayas){aya in
                AyaRow(for: aya, action: {quranVM.ayaOpenAction(aya)})
                    .padding(.vertical, -7)
                    .fullSeparatore2
            }
        } header: {
            if !kollection.ayas.ayas.isEmpty {
                Text(ayaSectionTitle)
            }
        }
        Section{
            ForEach(kollection.sofhas.sofhas){sofha in
                SofhaRow(for: sofha, action: {quranVM.sofhaOpenAction(sofha)})
                    .padding(.vertical, -7)
                    .fullSeparatore2
            }
        } header: {
            if !kollection.sofhas.sofhas.isEmpty {
                Text(sofhaSectionTitle)
            }
        }
        Section{
            ForEach(kollection.suras.suras){sura in
                SuraRow(for: sura, action: {quranVM.suraOpenAction(sura)})
                    .padding(.vertical, -7)
                    .fullSeparatore2
            }
        } header: {
            if !kollection.suras.suras.isEmpty {
                Text(suraSectionTitle)
            }
        }
    }
}

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
                Section("Detail"){
                    Text(kollection.descript)
                }
            }
            Section{
                ForEach(kollection.ayas.ayas){aya in
                    AyaRow(for: aya, action: {quranVM.ayaOpenAction(aya)})
                        .padding(.vertical, -5)
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
                        .padding(.vertical, -5)
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
                        .padding(.vertical, -5)
                        .fullSeparatore2
                }
            } header: {
                if !kollection.suras.suras.isEmpty {
                    Text(suraSectionTitle)
                }
            }
        }
        .navigationTitle(kollection.id)
        .toolbar{
            NavigationSheet(title: "Edit", presentationDetents: .init([.height(600)])) {
                AddKollectionView(kollection: .constant(kollection))
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

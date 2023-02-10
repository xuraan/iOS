//
//  KollectionView.swift
//  Quran
//
//  Created by Samba Diawara on 2023-02-09.
//

import SwiftUI

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
                    .fullSeparatore2
            }
        } header: {
            if !kollection.suras.suras.isEmpty {
                Text(suraSectionTitle)
            }
        }
    }
}

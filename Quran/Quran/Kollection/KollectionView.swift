//
//  KollectionView.swift
//  Quran
//
//  Created by Samba Diawara on 2023-02-09.
//

import SwiftUI

struct KollectionItemsSection: View {
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
        if !kollection.ayas.ayas.isEmpty {
            Section(ayaSectionTitle){
                ForEach(kollection.ayas.ayas){aya in
                    AyaRow(for: aya)
                }
            }
        }
        if !kollection.sofhas.sofhas.isEmpty {
            Section(sofhaSectionTitle){
                ForEach(kollection.sofhas.sofhas){sofha in
                    SofhaRow(for: sofha)
                }
            }
        }
        if !kollection.suras.suras.isEmpty {
            Section(suraSectionTitle){
                ForEach(kollection.suras.suras){sura in
                    SuraRow(for: sura)
                }
            }
        }
    }
}

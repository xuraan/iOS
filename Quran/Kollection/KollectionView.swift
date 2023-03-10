//
//  KollectionView.swift
//  Quran
//
//  Created by Samba Diawara on 2023-02-22.
//

import SwiftUI

struct KollectionView: View {
    @Environment(\.showCoverView) var showCoverView
    @ObservedObject var kollection: Kollection
    init(for kollection: Kollection, isEditable: Bool = true) {
        self.kollection = kollection
    }
    var body: some View {
        List{
            if !kollection.description.isEmpty {
                Text(kollection.description)
                    .listRowInsets(EdgeInsets())
                    .listRowBackground(Color.clear)
            }
            QuranItemSection(for: kollection.ayas, title: "ayas", limit: 5, isDismissible: false)
            QuranItemSection(for: kollection.hizbs, title: "hizbs", limit: 5, isDismissible: false)
            QuranItemSection(for: kollection.suras, title: "suras", limit: 5, isDismissible: false)
            QuranItemSection(for: kollection.sofhas, title: "sofhas", limit: 5, isDismissible: false)
        }
        .toolbar {
            editButton
        }
        .navigationTitle(kollection.name)
    }
    
    @ViewBuilder
    var editButton: some View {
        SheetButton("Edit") {
            NavigationStack{
                KollectionEditor(kollection: kollection)
                    .navigationTitle(kollection.name)
            }
            .presentationDetents([.height(470)])
        }
    }
}

struct KollectionView_Previews: PreviewProvider {
    static var previews: some View {
        KollectionView(for: KollectionProvider.favorite)
    }
}

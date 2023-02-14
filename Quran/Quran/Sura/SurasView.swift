//
//  SurasView.swift
//  Quran
//
//  Created by Samba Diawara on 2023-01-26.
//

import SwiftUI

struct SurasView: View {
    @Environment(\.pinned) var pinned
    @Environment(\.favorite) var favorite
    @EnvironmentObject var suraVM: SuraViewModel
    @EnvironmentObject var model: Model
    @EnvironmentObject var searchVM: SearchModel
    @EnvironmentObject var quraVM: QuranViewModel
    @EnvironmentObject var ayaVM: AyaViewModel
    @FetchRequest(sortDescriptors: [SortDescriptor(\.id)]) var suras: FetchedResults<Sura>

    @Binding var selection: Int
    init(selection: Binding<Int>) {
        self._selection = selection
    }
    var body: some View {
        PageView(
            selection: $selection,
            isReversed: true,
            pages: suras.map{ sura in
                SuraView(for: sura)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .environmentObject(suraVM)
                    .environmentObject(ayaVM)
                    .environmentObject(model)
                    .environmentObject(searchVM)
                    .environmentObject(quraVM)
                    .environment(\.favorite, favorite)
                    .environment(\.pinned, pinned)
                
            }
        )
        .ignoresSafeArea()
    }
}

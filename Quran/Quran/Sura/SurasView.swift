//
//  SurasView.swift
//  Quran
//
//  Created by Samba Diawara on 2023-01-26.
//

import SwiftUI

struct SurasView: View {
    @EnvironmentObject var suraVM: SuraViewModel
    @EnvironmentObject var quraVM: QuranViewModel
    @EnvironmentObject var ayaVM: AyaViewModel
    @FetchRequest(sortDescriptors: [SortDescriptor(\.id)]) var suras: FetchedResults<Sura>

    @Binding var selection: Int
    var closeAction: ()->Void
    var titleAction: ()->Void
    init(selection: Binding<Int>, closeAction: @escaping () -> Void, titleAction: @escaping () -> Void) {
        self._selection = selection
        self.closeAction = closeAction
        self.titleAction = titleAction
    }
    var body: some View {
        PageView(
            selection: $selection,
            isReversed: true,
            pages: suras.map{ sura in
                SuraView(for: sura, titleAction)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.primary.opacity(0.05).ignoresSafeArea())
                    .scaleEffect(x: 0.999)
                    .environmentObject(suraVM)
                    .environmentObject(ayaVM)
                    .environmentObject(quraVM)
            }
        )
        .ignoresSafeArea()
    }
}

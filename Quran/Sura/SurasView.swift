//
//  SurasView.swift
//  Quran
//
//  Created by Samba Diawara on 2023-01-26.
//

import SwiftUI

struct SurasView: View {
    @EnvironmentObject var suraVM: SuraViewModel
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
                    .background(Color.primary.opacity(0.03).ignoresSafeArea())
                    .scaleEffect(x: selection != sura.id-1 ?  0.99 : 1 )
                    .environmentObject(suraVM)
                    .environmentObject(ayaVM)
            }
        ).ignoresSafeArea()
//        .overlay(alignment: .topTrailing){
//            CloseButton(action: closeAction)
//                .padding(.horizontal)
//        }
    }
}

struct SurasView_Previews: PreviewProvider {
    static var previews: some View {
        SurasView(selection: .constant(1)){} titleAction: {}
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
            .environmentObject(SuraViewModel())

    }
}

//
//  QuranView.swift
//  Quran
//
//  Created by Samba Diawara on 2023-01-26.
//

import SwiftUI

struct QuranView: View {
    @EnvironmentObject var quranVM: QuranViewModel
    @Binding var isHideCloseButton: Bool
    init(isHideCloseButton: Binding<Bool>) {
        self._isHideCloseButton = isHideCloseButton
    }
    var body: some View {
        Group{
            switch quranVM.mode {
            case .sura:
                SurasView(selection: $quranVM.selection, closeAction: quranVM.hide, titleAction: {quranVM.isShowIndex=true})
            case .sofha:
                SofhasView(selection: $quranVM.selection, closeAction: quranVM.hide, SecondaryAction: {quranVM.isShowIndex=true}, isHideCloseButton: $isHideCloseButton)
            }
        }
        .environment(\.layoutDirection, .leftToRight)
        
    }
}

struct QuranView_Previews: PreviewProvider {
    static var previews: some View {
        QuranView(isHideCloseButton: .constant(false))
            .environmentObject(QuranViewModel())
            .environmentObject(SuraViewModel())
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)

    }
}

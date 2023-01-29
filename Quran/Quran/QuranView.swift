//
//  QuranView.swift
//  Quran
//
//  Created by Samba Diawara on 2023-01-26.
//

import SwiftUI

struct QuranView: View {
    @EnvironmentObject var quranVM: QuranViewModel
    var body: some View {
        Group{
            switch quranVM.mode {
            case .sura:
                SurasView(selection: $quranVM.selection, closeAction: quranVM.hide, titleAction: quranVM.showIndex)
            case .sofha:
                SofhasView(selection: $quranVM.selection, closeAction: quranVM.hide, SecondaryAction: quranVM.showIndex)
            }
        }
        .opacity(quranVM.isShow ? 1 : 0)
        .animation(.easeInOut.delay(quranVM.isShow ? 0.2 : -1), value: quranVM.isShow)
        
    }
}

struct QuranView_Previews: PreviewProvider {
    static var previews: some View {
        QuranView()
            .environmentObject(QuranViewModel())
            .environmentObject(SuraViewModel())
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)

    }
}

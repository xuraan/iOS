//
//  QuranView.swift
//  Quran
//
//  Created by Samba Diawara on 2023-01-26.
//

import SwiftUI

struct QuranView: View {
    @EnvironmentObject var quranVM: QuranViewModel
    @Environment(\.hideCoverView) var hideCoverView
    @Environment(\.showCoverView) var showCoverView
    @Binding var isHideCloseButton: Bool
    init(isHideCloseButton: Binding<Bool>) {
        self._isHideCloseButton = isHideCloseButton
    }
    var body: some View {
        Group{
            switch quranVM.mode {
            case .sura:
                SurasView(selection: $quranVM.selection, titleAction: {quranVM.isShowIndex=true})
            case .sofha:
                SofhasView(selection: $quranVM.selection, SecondaryAction: {quranVM.isShowIndex=true}, isHideCloseButton: $isHideCloseButton)
            }
        }
        .overlay(alignment: .topTrailing, content: {
            CloseButton(action: hideCoverView)
                .padding(.trailing)
        })
        .environment(\.layoutDirection, .leftToRight)
        .onAppear{
            quranVM.show = showCoverView
            print("Appear")
        }
        
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

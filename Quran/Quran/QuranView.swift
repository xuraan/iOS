//
//  QuranView.swift
//  Quran
//
//  Created by Samba Diawara on 2023-01-26.
//

import SwiftUI

struct QuranView: View {
    @EnvironmentObject var quranVM: QuranViewModel
    @Environment(\.hideCoverView) var hideSlideView
    @Environment(\.showCoverView) var showSlideView
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
            CloseButton(action: hideSlideView)
                .padding(.trailing)
                .opacity(isHideCloseButton ? 0 : 1)
        })
        .environment(\.layoutDirection, .leftToRight)
        .onAppear{
            quranVM.show = showSlideView
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

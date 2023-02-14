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
                SurasView(selection: $quranVM.selection)
            case .sofha:
                SofhasView(selection: $quranVM.selection, isHideCloseButton: $isHideCloseButton)
            }
        }
        .overlay(alignment: .topTrailing, content: {
            CloseButton(action: hideCoverView)
                .padding(.trailing)
                .opacity(isHideCloseButton ? 0 : 1)
        })
        .environment(\.layoutDirection, .leftToRight)
        .onAppear{
            quranVM.show = showCoverView
        }
    }
}

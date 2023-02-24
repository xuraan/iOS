//
//  QuranView.swift
//  Quran
//
//  Created by Samba Diawara on 2023-02-21.
//

import SwiftUI

struct QuranView: View {

    @State var hideToolbar: Bool = false
    @Environment(\.hideCoverView) var hideCoverView
    @EnvironmentObject var qModel: QuranViewModel
    var body: some View {
        Group{
            if qModel.tab == .sofha {
                SofhaPages(selection: $qModel.selection, hideToolbar: $hideToolbar)
            } else if qModel.tab == .sura {
                SuraPages(selection: $qModel.selection)
                    .ignoresSafeArea()
            }
        }
        .overlay(alignment: .topTrailing) {
            CloseButton(action: hideCoverView)
                .padding(.trailing)
                .offset(y: -10)
                .opacity(hideToolbar ? 0 : 1)
        }
        .overlay(alignment: .topLeading) {
            SheetButton {
                SettingsView()
                .presentationDetents(.init([.height(650)]))
            } label: {
                Image(systemName: "gear")
                    .glassBackground(size: 10)
            }
            .padding(.leading)
            .offset(y: -10)
            .opacity(hideToolbar ? 0 : 1)
        }
    }
}

struct QuranView_Previews: PreviewProvider {
    static var previews: some View {
        QuranView()
            .environmentObject(QuranViewModel())
    }
}

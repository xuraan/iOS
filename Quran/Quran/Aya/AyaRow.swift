//
//  AyaRow.swift
//  Quran
//
//  Created by Samba Diawara on 2023-02-18.
//

import SwiftUI

struct AyaRow: View {
    var aya: Aya
    init(for aya: Aya) {
        self.aya = aya
    }
    var body: some View {
        VStack(spacing: 5){
            aya.arabicTextView(lineLimit: 2)
                .font(CustomFont.mequran(20))
            aya.transTextView(lineLimit: 2)
                .font(.footnote.weight(.medium).italic())
        }
    }
}

struct AyaRow_Previews: PreviewProvider {
    static var previews: some View {
        AyaRow(for: QuranProvider.shared.aya(1))
    }
}

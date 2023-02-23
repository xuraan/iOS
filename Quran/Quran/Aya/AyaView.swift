//
//  AyaView.swift
//  Quran
//
//  Created by Samba Diawara on 2023-02-21.
//

import SwiftUI

struct AyaView: View {
    @EnvironmentObject var qModel: QuranViewModel
    let aya: Aya
    init(for aya: Aya) {
        self.aya = aya
    }
    var body: some View {
        VStack{
            aya.arabicTextView()
                .font(qModel.arabicFont.size(qModel.arabicFontSize))
            
            if qModel.isTransEnable {
                aya.transTextView()
                    .font(.system(size: qModel.transFontSize).weight(qModel.isTransBold ? .bold : .regular).italic())
            }
        }
        .contextMenu {
            StarButton(aya)
        }
        .id(aya.id)
    }
}

struct AyaView_Previews: PreviewProvider {
    static var previews: some View {
        AyaView(for: Aya.all[291])
    }
}

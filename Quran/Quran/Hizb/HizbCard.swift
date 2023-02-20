//
//  HizbCard.swift
//  Quran
//
//  Created by Samba Diawara on 2023-02-20.
//

import SwiftUI

struct HizbCard: View {
    let hizb: Hizb
    init(for hizb: Hizb) {
        self.hizb = hizb
    }
    var body: some View {
        AyasCard(ayas: Array(hizb.ayas.prefix(20))) {
            Text("Hizb \(hizb.id)")
                .font(.title3.bold())
        }
    }
}

struct HizbCard_Previews: PreviewProvider {
    static var previews: some View {
        HizbCard(for: QuranProvider.shared.hizb(60))
    }
}

//
//  SuraCard.swift
//  Quran
//
//  Created by Samba Diawara on 2023-02-20.
//

import SwiftUI

struct SuraCard: View {
    let sura: Sura
    init(for sura: Sura) {
        self.sura = sura
    }
    var body: some View {
        AyasCard(Array(sura.ayas.prefix(20))) {
            HStack{
                Text("ID \(sura.id)")
                Spacer()
                Text(sura.phonetic)
                Text(sura.translation)
                Spacer()
                Text(sura.name)
                    .font(.waseem(22, weight: .semibold))
            }
        } footer: {
            HStack{
                Text(sura.place)
                Text("\(sura.ayas.count) ayas")
            }
        }
    }
}

struct SuraCard_Previews: PreviewProvider {
    static var previews: some View {
        List{
            SuraCard(for: QuranProvider.shared.sura(1))
        }
    }
}

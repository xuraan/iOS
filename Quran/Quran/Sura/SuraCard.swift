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
        VStack{
            let ayas = sura.ayas.prefix(10)
            let text = ayas.map{ $0.textWithEndAya }.joined(separator: " ")
            let trans = ayas.map{ "\($0.number). \($0.translation)" }.joined(separator: " ")
            HStack{
                Text("ID \(sura.id)")
                Spacer()
                Text(sura.phonetic)
                Text(sura.translation)
                Spacer()
                Text(sura.name)
                    .font(.waseem(22, weight: .semibold))
            }
            .lineLimit(1)
            .font(.footnote.bold())
            .foregroundColor(.secondary)
            Text(text)
                .environment(\.layoutDirection, .rightToLeft)
                .font(CustomFont.mequran(22))
                .lineLimit(3)
            Text(trans)
                .environment(\.layoutDirection, .leftToRight)
                .foregroundColor(.secondary)
                .italic()
                .lineLimit(3)
            HStack{
                Text(sura.place)
                Text("\(sura.ayas.count) ayas")
            }
            .lineLimit(1)
            .font(.footnote.bold())
            .foregroundColor(.secondary)
            .offset(y: 10)
        }
        .environment(\.colorScheme, .dark)
        .padding()
        .listRowInsets(EdgeInsets())
        .listRowBackground(Color.accentColor)
    }
}

struct SuraCard_Previews: PreviewProvider {
    static var previews: some View {
        List{
            SuraCard(for: QuranProvider.shared.suras[78])
        }
    }
}

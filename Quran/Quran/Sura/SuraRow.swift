//
//  SuraRow.swift
//  Quran
//
//  Created by Samba Diawara on 2023-02-21.
//

import SwiftUI

struct SuraRow: View {
    @ObservedObject var favorite: Kollection = KollectionProvider.favorite
    let sura: Sura
    init(for sura: Sura) {
        self.sura = sura
    }
    var body: some View {
        Label(title: {
            HStack{
                Text(sura.phonetic)
                    .lineLimit(1)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                Text(sura.translation)
                    .lineLimit(1)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.subheadline)
                Spacer()
                Text(sura.name)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .font(.mequran(20))
                    .offset(y: -4)

            }
        }, icon: {
            RankView(text: "\(sura.id)", color: Color("bg"), bgColor: .favorite(favorite.contains(sura)))
                .offset(y: 2.2)
        })
        .environment(\.layoutDirection, .leftToRight)
        .swipeActions(edge: .trailing, allowsFullSwipe: true){
            StarButton(sura)
        }
    }
}

struct SuraRow_Previews: PreviewProvider {
    static var previews: some View {
        List{
            SuraRow(for: QuranProvider.shared.sura(1))
        }
    }
}

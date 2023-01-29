//
//  SuraRow.swift
//  Quran
//
//  Created by Samba Diawara on 2023-01-26.
//

import SwiftUI

struct SuraRow: View {
    @ObservedObject var sura: Sura
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
                    .mequran(20)
                    .offset(y: -2)

            }
        }, icon: {
            RankView(text: "\(sura.id)", color: Color("bg"), bgColor: sura.iconColor)
                .offset(y: 4)
        })
        .swipeActions(edge: .trailing){
            if sura.isFavorite {
                UnstarButton(action: {
                    withAnimation{
                        sura.isFavorite = false
                    }
                })
            } else {
                StarButton{
                    withAnimation{
                        sura.isFavorite = true
                    }
                }
            }
        }
        .environment(\.layoutDirection, .leftToRight)
    }
}


//
//  AyaRow.swift
//  Quran
//
//  Created by Samba Diawara on 2023-01-26.
//

import SwiftUI

struct AyaRow: View {
    @ObservedObject var aya: Aya
    init(for aya: Aya) {
        self.aya = aya
    }
    var body: some View {
        Label(title: {
            HStack(spacing:0){
                if let sura = aya.sura {
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
            }
            .offset(y: -4)
        }, icon: {
            RankView(
                text: "\(aya.sura.id):\(aya.number)",
                color: Color("bg"),
                bgColor: aya.iconColor
            )
            .offset(y: 4)
        })
        .swipeActions(edge: .trailing){
            if aya.isFavorite {
                UnstarButton(action: {
                    withAnimation{
                        aya.isFavorite = false
                    }
                })
            } else {
                StarButton{
                    withAnimation{
                        aya.isFavorite = true
                    }
                }
            }
        }

        .environment(\.layoutDirection, .leftToRight)
    }
}



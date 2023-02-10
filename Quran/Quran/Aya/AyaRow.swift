//
//  AyaRow.swift
//  Quran
//
//  Created by Samba Diawara on 2023-01-26.
//

import SwiftUI

struct AyaRow: View {
    @ObservedObject var aya: Aya
    @Environment(\.pinned) var pinned
    @Environment(\.favorite) var favorite

    var action: ()-> Void
    init(for aya: Aya, action: @escaping () -> Void = {}) {
        self.aya = aya
        self.action = action
    }
    var body: some View {
        let isFavorite = aya.isElement(of: favorite)
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
                bgColor: .favorite(isFavorite)
            )
            .offset(y: 4)
        })
        .swipeActions(edge: .trailing){
            aya.menu(favorite: favorite, pinned: pinned)
        }
        .onTapGesture(perform: action)
        .environment(\.layoutDirection, .leftToRight)
    }
}



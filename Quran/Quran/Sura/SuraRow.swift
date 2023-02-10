//
//  SuraRow.swift
//  Quran
//
//  Created by Samba Diawara on 2023-01-26.
//

import SwiftUI

struct SuraRow: View {
    @ObservedObject var sura: Sura
    @Environment(\.favorite) var favorite
    @Environment(\.pinned) var pinned

    @EnvironmentObject var model: Model
    @EnvironmentObject var quranVM: QuranViewModel
    @EnvironmentObject var suraVM: SuraViewModel
    @EnvironmentObject var searchVM: SearchModel
    @EnvironmentObject var ayaVM: AyaViewModel
    var action: ()-> Void
    init(for sura: Sura,  action: @escaping () -> Void = {}) {
        self.sura = sura
        self.action = action
    }
    var body: some View {
        let isFavorite = sura.isElement(of: favorite)
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
            RankView(text: "\(sura.id)", color: Color("bg"), bgColor: .favorite(isFavorite))
                .offset(y: 4)
        })
        .swipeActions(edge: .trailing){
            sura.menu(favorite: favorite, pinned: pinned)
        }
        .onTapGesture(perform: action)
        .environment(\.layoutDirection, .leftToRight)
    }
}


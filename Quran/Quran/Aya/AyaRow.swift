//
//  AyaRow.swift
//  Quran
//
//  Created by Samba Diawara on 2023-01-26.
//

import SwiftUI

struct AyaRow: View {
    @ObservedObject var aya: Aya
    @Environment(\.favorite) var favorite

    @EnvironmentObject var model: Model
    @EnvironmentObject var quranVM: QuranViewModel
    @EnvironmentObject var suraVM: SuraViewModel
    @EnvironmentObject var searchVM: SearchModel
    @EnvironmentObject var ayaVM: AyaViewModel
    init(for aya: Aya) {
        self.aya = aya
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
        .contextMenu(menuItems: {
            if isFavorite {
                UnstarButton(action: {
                    withAnimation{
                        aya.removeFromKollections(favorite)
                    }
                })
            } else {
                StarButton{
                    withAnimation{
                        aya.addToKollections(favorite)
                    }
                }
            }
        }, preview: {
            AyaView(for: aya)
                .environmentObject(model)
                .environmentObject(quranVM)
                .environmentObject(suraVM)
                .environmentObject(searchVM)
                .environmentObject(ayaVM)
                .frame(width: 400, height: 350)
        })
        .swipeActions(edge: .leading){
            if isFavorite {
                UnstarButton(action: {
                    withAnimation{
                        aya.removeFromKollections(favorite)
                    }
                })
            } else {
                StarButton{
                    withAnimation{
                        aya.addToKollections(favorite)
                    }
                }
            }        }
        
        .environment(\.layoutDirection, .leftToRight)
    }
}



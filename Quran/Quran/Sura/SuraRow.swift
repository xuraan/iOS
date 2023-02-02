//
//  SuraRow.swift
//  Quran
//
//  Created by Samba Diawara on 2023-01-26.
//

import SwiftUI

struct SuraRow: View {
    @ObservedObject var sura: Sura
    @EnvironmentObject var model: Model
    @EnvironmentObject var quranVM: QuranViewModel
    @EnvironmentObject var suraVM: SuraViewModel
    @EnvironmentObject var searchVM: SearchModel
    @EnvironmentObject var ayaVM: AyaViewModel
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
        .contextMenu(menuItems: {
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
        }, preview: {
            SuraView(for: sura)
                .environmentObject(model)
                .environmentObject(quranVM)
                .environmentObject(suraVM)
                .environmentObject(searchVM)
                .environmentObject(ayaVM)
                .frame(width: 300, height: 500)
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


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
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var model: Model
    @EnvironmentObject var quranVM: QuranViewModel
    @EnvironmentObject var suraVM: SuraViewModel
    @EnvironmentObject var searchVM: SearchModel
    @EnvironmentObject var ayaVM: AyaViewModel
    var action: (()-> Void)?
    init(for aya: Aya, action: (() -> Void)? = nil) {
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
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background()
        .swipeActions(edge: .trailing){
            aya.menu(favorite: favorite, pinned: pinned)
        }
        .swipeActions(edge: .leading){
            Button("show in quran", action: {quranVM.ayaOpenAction(aya)})
                .tint(.blue)
        }
        
        .contextMenu(menuItems: {
            aya.menu(favorite: favorite, pinned: pinned)
        }, preview: {
            Image("1")
                .resizable()
                .opacity(0)
                .overlay{
                    AyaView(for: aya)
                }
                .environmentObject(quranVM)
                .environmentObject(ayaVM)
                .environmentObject(searchVM)
                .environmentObject(model)
                .environment(\.pinned, pinned)
                .environment(\.favorite, favorite)
        })
        .onTapGesture(perform: (action.isNil ? {
            dismiss()
            quranVM.ayaOpenAction(aya)
        } : action)!)
        .environment(\.layoutDirection, .leftToRight)
    }
}

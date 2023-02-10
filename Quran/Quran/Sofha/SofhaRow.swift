//
//  SofhaRow.swift
//  Quran
//
//  Created by Samba Diawara on 2023-01-26.
//

import SwiftUI

struct SofhaRow: View {
    @ObservedObject var sofha: Sofha
    @Environment(\.favorite) var favorite
    @Environment(\.pinned) var pinned
    init(for sofha: Sofha) {
        self.sofha = sofha
    }
    
    var body: some View {
        let isFavorite = sofha.isElement(of: favorite)
        Label(title: {
            HStack{
                if let first = sofha.ayas.ayas.first, let last = sofha.ayas.ayas.last  {
                    
                    last.arabicTextView(lineLimit: 1)
                        .mequran(20)
                        .frame(maxWidth: .infinity, alignment: .leading)

                    first.arabicTextView(lineLimit: 1)
                        .mequran(20)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                }
            }
            .offset(y: -4)
        }, icon: {
            RankView(text: "\(sofha.id)", color: Color("bg"), bgColor: .favorite(isFavorite))
                .offset(y: 4)
        })
        .swipeActions(edge: .trailing){
            sofha.menu(favorite: favorite, pinned: pinned)
        }
        .environment(\.layoutDirection, .leftToRight)
    }
}


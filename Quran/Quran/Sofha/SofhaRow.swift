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
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.showCoverView) var showCoverView
    var action: ()-> Void
    init(for sofha: Sofha, action: @escaping () -> Void = {}) {
        self.sofha = sofha
        self.action = action
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
        .contextMenu(menuItems: {
            sofha.menu(favorite: favorite, pinned: pinned)
            
            Menu("suras", content: {
                ForEach(sofha.surasFullNames, id: \.self){ name in Text(name)}
            })
            Divider()
            Button(action: showCoverView, label: {
                Text("Open in quran")
            })
            
        }, preview: {
            sofha.image(colorScheme: colorScheme)
        })
        .swipeActions(edge: .trailing){
            sofha.menu(favorite: favorite, pinned: pinned)
        }
        .onTapGesture(perform: action)
        .environment(\.layoutDirection, .leftToRight)
    }
}


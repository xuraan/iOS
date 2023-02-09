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
        .contextMenu(menuItems: {
            if isFavorite {
                UnstarButton(action: {
                    withAnimation{
                        sofha.removeFromKollections(favorite)
                    }
                })
            } else {
                StarButton{
                    withAnimation{
                        sofha.addToKollections(favorite)
                    }
                }
            }
        }, preview: {
            sofha.image(colorScheme: .light)
        })
        .swipeActions(edge: .leading){
            if isFavorite {
                UnstarButton(action: {
                    withAnimation{
                        sofha.removeFromKollections(favorite)
                    }
                })
            } else {
                StarButton{
                    withAnimation{
                        sofha.addToKollections(favorite)
                    }
                }
            }
        }
        .environment(\.layoutDirection, .leftToRight)
    }
}


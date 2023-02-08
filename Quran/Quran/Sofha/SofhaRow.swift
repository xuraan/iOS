//
//  SofhaRow.swift
//  Quran
//
//  Created by Samba Diawara on 2023-01-26.
//

import SwiftUI

struct SofhaRow: View {
    @ObservedObject var sofha: Sofha
    
    init(for sofha: Sofha) {
        self.sofha = sofha
    }
    
    var body: some View {
        Label(title: {
            HStack{
                if let first = sofha.ayas.toAyas.first, let last = sofha.ayas.toAyas.last  {
                    
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
            RankView(text: "\(sofha.id)", color: Color("bg"), bgColor: sofha.iconColor)
                .offset(y: 4)
        })
        .contextMenu(menuItems: {
            if sofha.isFavorite {
                UnstarButton(action: {
                    withAnimation{
                        sofha.isFavorite = false
                    }
                })
            } else {
                StarButton{
                    withAnimation{
                        sofha.isFavorite = true
                    }
                }
            }
        }, preview: {
            sofha.image(colorScheme: .light)
        })
        .swipeActions(edge: .leading){
            if sofha.isFavorite {
                UnstarButton(action: {
                    withAnimation{
                        sofha.isFavorite = false
                    }
                })
            } else {
                StarButton{
                    withAnimation{
                        sofha.isFavorite = true
                    }
                }
            }
        }
        .environment(\.layoutDirection, .leftToRight)
    }
}


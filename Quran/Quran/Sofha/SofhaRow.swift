//
//  SofhaRow.swift
//  Quran
//
//  Created by Samba Diawara on 2023-02-21.
//

import SwiftUI

struct SofhaRow: View {
    let sofha: Sofha
    @ObservedObject var favorite: Kollection = KollectionProvider.favorite
    init(for sofha: Sofha) {
        self.sofha = sofha
    }
    var body: some View {
        Label(title: {
            HStack{
                if let first = sofha.ayas.first, let last = sofha.ayas.last  {
                    last.arabicTextView(lineLimit: 1)
                        .font(.mequran(20))
                        .frame(maxWidth: .infinity, alignment: .leading)

                    first.arabicTextView(lineLimit: 1)
                        .font(.mequran(20))
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
        }, icon: {
            RankView(text: "\(sofha.id)", color: Color("bg"), bgColor: .favorite(favorite.contains(sofha)))
                .offset(y: 5)
        })
        .environment(\.layoutDirection, .leftToRight)
        .swipeActions {
            StarButton(sofha)
        }
    }
}

struct SofhaRow_Previews: PreviewProvider {
    static var previews: some View {
        List{
            SofhaRow(for: QuranProvider.shared.sofha(2))
        }
    }
}

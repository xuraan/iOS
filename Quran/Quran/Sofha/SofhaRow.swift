//
//  SofhaRow.swift
//  Quran
//
//  Created by Samba Diawara on 2023-02-21.
//

import SwiftUI

struct SofhaRow: View {
    let sofha: Sofha
    var isDismissible: Bool

    @Environment(\.dismiss) var dismiss
    @Environment(\.showCoverView) var showCoverView
    @EnvironmentObject var qModel: QuranViewModel
    
    @ObservedObject var favorite: Kollection = KollectionProvider.favorite
    
    init(for sofha: Sofha, isDismissible: Bool = true) {
        self.sofha = sofha
        self.isDismissible = isDismissible
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
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.primary.opacity(0.00001))
        .onTapGesture {
            if isDismissible {
                dismiss()
            }
            showCoverView()
            qModel.openButtonAction(sofha.ayas.first!)
        }
        .environment(\.layoutDirection, .leftToRight)
        .swipeActions {
            StarButton(sofha)
            PinButton(sofha)

        }
    }
}

struct SofhaRow_Previews: PreviewProvider {
    static var previews: some View {
        List{
            SofhaRow(for: QuranProvider.shared.sofha(2)!)
        }
    }
}

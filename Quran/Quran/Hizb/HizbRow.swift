//
//  HizbRow.swift
//  Quran
//
//  Created by Samba Diawara on 2023-02-21.
//

import SwiftUI

struct HizbRow: View {
    let hizb: Hizb
    var action: (() -> Void)?

    @Environment(\.dismiss) var dismiss
    @Environment(\.showCoverView) var showCoverView
    @EnvironmentObject var qModel: QuranViewModel
    @ObservedObject var favorite: Kollection = KollectionProvider.favorite
    init(for hizb: Hizb, action: (() -> Void)? = nil) {
        self.hizb = hizb
        self.action = action
    }
    var body: some View {
        Label(title: {
            HStack{
                if let first = hizb.ayas.first  {
                    first.arabicTextView(lineLimit: 1)
                        .font(.mequran(20))
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
        }, icon: {
            RankView(text: "\(hizb.id)", color: Color("bg"), bgColor: .favorite(favorite.contains(hizb)))
                .offset(y: 5)
        })
        .onTapGesture {
            if let action = action {
                action()
            } else {
                dismiss()
                showCoverView()
                qModel.openButtonAction(hizb.ayas.first!)
            }
        }
        .environment(\.layoutDirection, .leftToRight)
        .swipeActions {
            StarButton(hizb)
            PinButton(hizb)
        }
    }
}

struct HizbRow_Previews: PreviewProvider {
    static var previews: some View {
        List{
            HizbRow(for: QuranProvider.shared.hizb(4))
        }
    }
}

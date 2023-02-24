//
//  HizbRow.swift
//  Quran
//
//  Created by Samba Diawara on 2023-02-21.
//

import SwiftUI

struct HizbRow: View {
    let hizb: Hizb
    var isDismissible: Bool

    @Environment(\.dismiss) var dismiss
    @Environment(\.showCoverView) var showCoverView
    @EnvironmentObject var qModel: QuranViewModel
    @ObservedObject var favorite: Kollection = KollectionProvider.favorite
    init(for hizb: Hizb, isDismissible:Bool = true) {
        self.hizb = hizb
        self.isDismissible = isDismissible
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
            RankView(text: "\(hizb.id)", color: .init(uiColor: UIColor.systemBackground), bgColor: .favorite(favorite.contains(hizb)))
                .offset(y: 5)
        })
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.primary.opacity(0.00001))
        .onTapGesture {
            if isDismissible {
                dismiss()
            }
            showCoverView()
            qModel.openButtonAction(hizb.ayas.first!)
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
            HizbRow(for: QuranProvider.shared.hizb(4)!)
        }
    }
}

//
//  AyaRow.swift
//  Quran
//
//  Created by Samba Diawara on 2023-02-18.
//

import SwiftUI

struct AyaRow: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.showCoverView) var showCoverView
    @EnvironmentObject var qModel: QuranViewModel
    @ObservedObject var favorite: Kollection = KollectionProvider.favorite
    var aya: Aya
    var isDismissible: Bool
    
    init(for aya: Aya, isDismissible: Bool = true) {
        self.aya = aya
        self.isDismissible = isDismissible
    }
    var body: some View {
        Label(title: {
            HStack(spacing:0){
                let sura = aya.sura
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
                    .font(.mequran(20))
                    .offset(y: -3)
            }
        }, icon: {
            RankView(
                text: "\(aya.sura.id):\(aya.number)",
                color: .init(uiColor: UIColor.systemBackground),
                bgColor: .favorite(favorite.contains(aya))
            )
            .offset(y: 5)
        })
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.primary.opacity(0.00001))
        .onTapGesture {
            if isDismissible {
                dismiss()
            }
            showCoverView()
            qModel.openButtonAction(aya)
        }
        .environment(\.layoutDirection, .leftToRight)
        .swipeActions(edge: .trailing, allowsFullSwipe: true){
            StarButton(aya)
            PinButton(aya)
        }
        .contextMenu {
            StarButton(aya)
        }
    }
    
    
}

struct AyaRow_Previews: PreviewProvider {
    static var previews: some View {
        List{
            AyaRow(for: QuranProvider.shared.aya(1)!)
        }
    }
}

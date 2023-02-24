//
//  SuraRow.swift
//  Quran
//
//  Created by Samba Diawara on 2023-02-21.
//

import SwiftUI

struct SuraRow: View {
    @Environment(\.showCoverView) var showCoverView
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var qModel: QuranViewModel
    @ObservedObject var favorite: Kollection = KollectionProvider.favorite
    let sura: Sura
    var isDismissible: Bool

    init(for sura: Sura, isDismissible: Bool = true) {
        self.sura = sura
        self.isDismissible = isDismissible
    }
    var body: some View {
        Label(title: {
            HStack{
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
                    .offset(y: -4)

            }
        }, icon: {
            RankView(text: "\(sura.id)", color: .init(uiColor: UIColor.systemBackground), bgColor: .favorite(favorite.contains(sura)))
                .offset(y: 2.2)
        })
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.primary.opacity(0.00001))
        .onTapGesture {
            if isDismissible {
                dismiss()
            }
            showCoverView()
            qModel.openButtonAction(sura.ayas.first!)
        }
        
        .environment(\.layoutDirection, .leftToRight)
        .swipeActions(edge: .trailing, allowsFullSwipe: true){
            StarButton(sura)
            PinButton(sura)
        }
    }
}

struct SuraRow_Previews: PreviewProvider {
    static var previews: some View {
        List{
            SuraRow(for: QuranProvider.shared.sura(1)!)
        }
    }
}

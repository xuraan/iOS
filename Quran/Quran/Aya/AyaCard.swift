//
//  AyaCard.swift
//  Quran
//
//  Created by Samba Diawara on 2023-02-20.
//

import SwiftUI

struct AyaCard: View {
    let aya: Aya
    
    init(for aya: Aya) {
        self.aya = aya
    }
    
    var body: some View {
        VStack{
            HStack{
                Group{
                    Text(aya.secondaryID)
                    Spacer()
                    Text(aya.sura.name)
                        .font(CustomFont.waseem(22))
                    Spacer()
                    Text("Page. \(aya.sofhaID)")
                    Spacer()
                    Text("Hizb. \(aya.hizbID)")
                }
                .font(.footnote.bold())
                
            }
            .foregroundColor(.secondary)
            aya.arabicTextView(lineLimit: 5)
                .font(CustomFont.mequran(22))
            aya.transTextView(lineLimit: 4)
                .font(.title3.weight(.light).italic())
        }
        .environment(\.colorScheme, .dark)
        .padding()
        .listRowInsets(EdgeInsets())
        .background(Color.accentColor)
    }
}

struct AyaCard_Previews: PreviewProvider {
    static var previews: some View {
        List{
            AyaCard(for: QuranProvider.shared.ayas[291])
        }
    }
}

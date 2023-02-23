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
        AyasCard([aya]) {
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
        }
    }
}

struct AyaCard_Previews: PreviewProvider {
    static var previews: some View {
        List{
            AyaCard(for: QuranProvider.shared.aya(290)!)
        }
    }
}

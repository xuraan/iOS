//
//  AyaView.swift
//  Quran
//
//  Created by Samba Diawara on 2023-01-26.
//

import SwiftUI

struct AyaView: View {
    @ObservedObject var aya: Aya
    @EnvironmentObject var ayaVM: AyaViewModel
    init(for aya: Aya) {
        self.aya = aya
    }
    var body: some View {
        VStack{
            aya.arabicTextView()
                .font(.custom(ayaVM.ayaFontName, size: ayaVM.ayaFontSize))
                
            
            if ayaVM.isTransEnable {
                aya.transTextView()
                    .font(.system(size: ayaVM.transFontSize).italic())
                    .fontWeight(ayaVM.isTransBold ? .bold : .regular)
            }
        }
        .padding(.horizontal, 7)
        .background{
            Color.yellow
                .blur(radius: 10)
                .opacity(aya.isFavorite ? 0.5 : 0.00001)
                .ignoresSafeArea()
        }
        .contextMenu(menuItems: {
            if aya.isFavorite {
                UnstarButton(action: {
                    withAnimation{
                        aya.isFavorite = false
                    }
                })
            } else {
                StarButton{
                    withAnimation{
                        aya.isFavorite = true
                    }
                }
            }
        })
        .id(aya.id)
    }
}



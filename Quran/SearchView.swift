//
//  SearchView.swift
//  Quran
//
//  Created by Samba Diawara on 2023-02-20.
//

import SwiftUI

struct SearchView: View {
    @EnvironmentObject var model: Model
    
    @State var ayas: [Aya] = []
    @State var suras: [Sura] = []
    @State var hizbs: [Hizb] = []
    @State var sofhas: [Sofha] = []
    
    var body: some View {
        QuranItemSection(for: ayas, title: "ayas", limit: 4)
        QuranItemSection(for: hizbs, title: "hizbs")
        QuranItemSection(for: sofhas, title: "sofhas")
        QuranItemSection(for: suras, title: "suras")
            
            .onReceive(model.$text){ text in
                search(text: text)
            }
    }

    func search(text: String){
        Task{
            suras = await QuranProvider.shared.searchSuras(text: text).shuffled()
            sofhas = await QuranProvider.shared.searchSofhas(text: text).shuffled()
            hizbs = await QuranProvider.shared.searchHizb(text: text).shuffled()
            ayas = await QuranProvider.shared.searchAyas(text: text).shuffled()
        }
    }
}

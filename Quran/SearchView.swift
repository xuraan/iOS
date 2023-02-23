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
        QuranItemSection(for: ayas, title: "ayas", limit: 2)
        QuranItemSection(for: hizbs, title: "hizbs", limit: 2)
        QuranItemSection(for: sofhas, title: "sofhas", limit: 2)
        QuranItemSection(for: suras, title: "suras", limit: 2)
            
            .onReceive(model.$text){ text in
                search(text: text)
            }
    }

    func search(text: String){
        Task{
            suras = await QuranProvider.shared.searchSuras(text: text)
            sofhas = await QuranProvider.shared.searchSofhas(text: text)
            hizbs = await QuranProvider.shared.searchHizb(text: text)
            ayas = await QuranProvider.shared.searchAyas(text: text)
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
       SearchView()
    }
}

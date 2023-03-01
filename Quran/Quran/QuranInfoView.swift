//
//  QuranInfoView.swift
//  Quran
//
//  Created by Samba Diawara on 2023-02-28.
//

import SwiftUI

struct QuranInfoView: View {
    var body: some View {
        Section{
            NavigationLink(destination: {
                info()
            }, label: {
                Label("What is the noble quran", systemImage: "questionmark.ar")
            })
        }
    }
    
    @ViewBuilder
    func info() -> some View {
        List{
            Text("QURANDESCRIPTION")
                .listRowInsets(EdgeInsets())
                .listRowBackground(Color.clear)
            
            QuranItemSection(for: Aya.all, title: "ayas", isDismissible: false)
            QuranItemSection(for: Hizb.all, title: "Hizbs", isDismissible: false)
            QuranItemSection(for: Aya.sajda, title: "sajdas",isDismissible: false)
            QuranItemSection(for: Sofha.all, title: "sofhas", isDismissible: false)
            QuranItemSection(for: Sura.all, title: "suras",isDismissible: false)
        }
        .padding(.top, -20)
        .navigationTitle("Info")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct QuranInfoView_Previews: PreviewProvider {
    static var previews: some View {
        QuranInfoView()
    }
}

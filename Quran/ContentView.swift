//
//  ContentView.swift
//  Quran
//
//  Created by Samba Diawara on 2023-01-27.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @State var isShow: Bool = false
    @State var text: String = ""
    
    @State var surasResult: [Sura] = []
    @State var ayasResult: [Aya] = []
    @State var sofhasResult: [Sofha] = []
    @State var hizbsResult: [Hizb] = []
    
    var body: some View {
        Container($isShow, searchText: $text) {
            List{
                
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button{
                        
                    }label: {
                        Image(systemName: "gear")
                    }
                }
            }
        } cover: {
            Color.green.ignoresSafeArea()
        } searchView: {
            SearchView(
                ayas: $ayasResult,
                suras: $surasResult,
                hizbs: $hizbsResult,
                sofhas: $sofhasResult
            )
        }
        .onChange(of: text) { newValue in
            Task{
                surasResult = await QuranProvider.shared.searchSuras(text: text.lowercased())
                
                sofhasResult = await QuranProvider.shared.searchSofhas(text: text.lowercased())
                
                hizbsResult = await QuranProvider.shared.searchHizb(text: text.lowercased())
                
                ayasResult = await QuranProvider.shared.searchAyas(text: text.lowercased())
            }
            
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

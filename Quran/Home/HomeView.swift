//
//  HomeView.swift
//  Quran
//
//  Created by Samba Diawara on 2023-01-26.
//

import SwiftUI
import CoreData

struct HomeView: View {
    @Environment(\.isSearching) var isSearching
    @Binding var text: String
    
    @FetchRequest(
        sortDescriptors: [SortDescriptor(\.id)],
        predicate: NSPredicate(format: ("isFavorite == true"))
    ) var suras: FetchedResults<Sura>
    @FetchRequest(
        sortDescriptors: [SortDescriptor(\.id)],
        predicate: NSPredicate(format: ("isFavorite == true"))
    ) var ayas: FetchedResults<Aya>
    @FetchRequest(
        sortDescriptors: [SortDescriptor(\.id)],
        predicate: NSPredicate(format: ("isFavorite == true"))
    ) var sofhas: FetchedResults<Sofha>
    
    init(text: Binding<String> = .constant("")) {
        self._text = text
    }
    
    var body: some View {
        List{
            if isSearching {
                SearchView(text: $text)
                    .environment(\.isDestructive, false)
            } else {
                favoriteSuraSection()
                favoriteSofhaSection()
                favoriteAyaSection()
            }
            Section{}
        }
        .environment(\.isDestructive, true)
        .animation(.easeInOut, value: suras.count)
        .animation(.easeInOut, value: sofhas.count)
        .animation(.easeInOut, value: ayas.count)
        .navigationTitle(isSearching ? "Search" : "The noble quran")
    }
    
    @ViewBuilder
    func favoriteSuraSection()-> some View {
        if !suras.isEmpty {
            Section{
                ForEach(suras.prefix(2)){ sura in
                    ListRowButton(action: {}){
                        SuraRow(for: suras.first!)
                            .padding(0)
                    }
                }
            } header: {
                HStack{
                    Text("Favorites sura")
                    Spacer()
                    if suras.count > 2 {
                        MoreLink{
                            SuraList(suras: suras.map{$0})
                            .navigationTitle("Favorites sura")
                            .environment(\.isDestructive, true)
                        }

                    }
                }
            }
        }

    }
    @ViewBuilder
    func favoriteSofhaSection()-> some View {
        if !sofhas.isEmpty {
            Section{
                ForEach(sofhas.prefix(2)){ sofha in
                    ListRowButton(action: {}){
                        SofhaRow(for: sofha)
                            .padding(0)
                    }
                }
            } header: {
                HStack{
                    Text("Favorites sofhas")
                    Spacer()
                    if sofhas.count > 2 {
                        MoreLink{
                            SofhaList(sofhas: sofhas.map{$0})
                            .navigationTitle("Favorites sofhas")
                            .environment(\.isDestructive, true)
                        }
                    }
                }
            }
        }

    }
    @ViewBuilder
    func favoriteAyaSection()-> some View {
        if !ayas.isEmpty {
            Section{
                ForEach(ayas.prefix(2)){ aya in
                    ListRowButton(action: {}){
                        AyaRow(for: aya)
                            .padding(0)
                    }
                }
            } header: {
                HStack{
                    Text("Favorites aya")
                    Spacer()
                    if sofhas.count > 2 {
                        MoreLink{
                            AyaList(ayas: ayas.map{$0})
                            .navigationTitle("Favorites ayas")
                            .environment(\.isDestructive, true)
                        }
                    }
                }
            }
        }
    }
    
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}



struct RowButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(.horizontal)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color("bg1"))
            .overlay{
                Color.black.opacity( configuration.isPressed ? 0.3 : 0 )
            }
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}

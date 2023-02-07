//
//  HomeView.swift
//  Quran
//
//  Created by Samba Diawara on 2023-01-26.
//

import SwiftUI
import CoreData

struct HomeView: View {
    @EnvironmentObject var quranVM: QuranViewModel
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
        }
        .listStyle(.insetGrouped)
        .environment(\.isDestructive, true)
        .animation(.easeInOut, value: suras.isEmpty)
        .animation(.easeInOut, value: sofhas.isEmpty)
        .animation(.easeInOut, value: ayas.isEmpty)
        .navigationTitle(isSearching ? "Search" : "The noble quran")
    }
    
    @ViewBuilder
    func favoriteSuraSection()-> some View {
        if !suras.isEmpty {
            Section{
                ForEach(suras){ sura in
                    ListRowButton(action: {
                        quranVM.suraOpenAction(sura)
                    }){
                        SuraRow(for: sura)
                            .padding(0)
                    }
                }
            } header: {
                HStack{
                    Text("Favorites sura")
                    Spacer()
                    Text("\(suras.count)")
                }
            }
        }

    }
    @ViewBuilder
    func favoriteSofhaSection()-> some View {
        if !sofhas.isEmpty {
            Section{
                ForEach(sofhas){ sofha in
                    ListRowButton(action: {
                        quranVM.sofhaOpenAction(sofha)
                    }){
                        SofhaRow(for: sofha)
                            .padding(0)
                    }
                }
            } header: {
                HStack{
                    Text("Favorites sofhas")
                    Spacer()
                    Text("\(sofhas.count)")
                }
            }
        }

    }
    @ViewBuilder
    func favoriteAyaSection()-> some View {
        if !ayas.isEmpty {
            Section{
                ForEach(ayas){ aya in
                    ListRowButton(action: {
                        quranVM.ayaOpenAction(aya)
                    }){
                        AyaRow(for: aya)
                            .padding(0)
                    }
                }
            } header: {
                HStack{
                    Text("Favorites aya")
                    Spacer()
                    Text("\(ayas.count)")
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

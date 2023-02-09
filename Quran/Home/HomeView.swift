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
    @Environment(\.showSlideView) var showSlideView
    @Environment(\.isSearching) var isSearching
    @Binding var text: String

    
    init(text: Binding<String> = .constant("")) {
        self._text = text
    }
    
    var body: some View {
        List{
            if isSearching {
                SearchView(text: $text)
                    .environment(\.isDestructive, false)
            } else {
                HStack{
                    Spacer()
                    Button(action: showSlideView, label: {
                        Text("Open quran").font(.headline)
                    })
                    .buttonStyle(.borderless)
                }
                
                .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                .listRowBackground(Color.clear)
            }
            Section{}
        }
        
        .listStyle(.insetGrouped)
        .environment(\.isDestructive, true)
        .navigationTitle(isSearching ? "Search" : "The noble quran")
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
